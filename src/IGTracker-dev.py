




# manual_multi_account_tracker.py
from instagrapi import Client
import psycopg2

def connect_postgres():
    conn = psycopg2.connect(
        host="localhost",
        port="5432",
        dbname="instagram_tracker",
        user="postgres",
        password="p0w2i8"
    )
    return conn

def show_saved_accounts(conn):
    cur = conn.cursor()
    cur.execute("SELECT account_id, username FROM instagram_accounts ORDER BY account_id")
    accounts = cur.fetchall()
    cur.close()

    if not accounts:
        print("No saved Instagram accounts found.")
        return None

    print("\nSaved Instagram Accounts:")
    for aid, uname in accounts:
        print(f"{aid}: {uname}")
    return accounts

def get_account_choice(conn):
    accounts = show_saved_accounts(conn)

    print("\nEnter an Account ID from the list above OR enter a new Instagram username.")
    choice = input("Your choice: ").strip()

    cur = conn.cursor()

    try:
        account_id = int(choice)
        cur.execute("SELECT username, password FROM instagram_accounts WHERE account_id = %s", (account_id,))
        result = cur.fetchone()
        if result:
            username, password = result
            cur.close()
            return username, password, account_id
        else:
            print("❌ Invalid account ID.")
            cur.close()
            return None, None, None
    except ValueError:
        # It's a username
        username = choice
        password = input(f"Enter password for {username}: ")
        # Insert into DB for future reuse
        try:
            cur.execute(
                "INSERT INTO instagram_accounts (username, password) VALUES (%s, %s) RETURNING account_id",
                (username, password)
            )
            account_id = cur.fetchone()[0]
            conn.commit()
            cur.close()
            return username, password, account_id
        except Exception as e:
            print(f"❌ Failed to save new account: {e}")
            conn.rollback()
            cur.close()
            return None, None, None

def login_to_instagram(username, password):
    cl = Client()
    try:
        cl.login(username, password)
        print("✅ Successfully logged into Instagram")
        return cl
    except Exception as e:
        print(f"❌ Login failed: {e}")
        return None

def get_current_follows_from_db(conn, account_id):
    cur = conn.cursor()
    cur.execute("SELECT username FROM current_follows WHERE account_id = %s", (account_id,))
    follows = set(row[0] for row in cur.fetchall())
    cur.close()
    return follows

def update_follow_data(cl, conn, account_id):
    user_id = cl.user_id
    following = cl.user_following(user_id)

    ig_users = set()
    user_info_map = {}

    for user_id_ig, user_data in following.items():
        ig_users.add(user_data.username)
        user_info_map[user_data.username] = {
            "full_name": user_data.full_name
        }

    cur = conn.cursor()

    db_users = get_current_follows_from_db(conn, account_id)

    # New follows
    new_follows = ig_users - db_users
    for username in new_follows:
        info = user_info_map[username]
        full_name = info["full_name"]
        cur.execute(
            "INSERT INTO current_follows (account_id, username, full_name) VALUES (%s, %s, %s)",
            (account_id, username, full_name)
        )
        cur.execute(
            "INSERT INTO follow_history (account_id, username, full_name, action) VALUES (%s, %s, %s, 'follow')",
            (account_id, username, full_name)
        )
        print(f"Followed: {username} - {full_name}")

    # Unfollows
    unfollowed_users = db_users - ig_users
    for username in unfollowed_users:
        cur.execute("SELECT full_name FROM current_follows WHERE username = %s AND account_id = %s", (username, account_id))
        full_name = cur.fetchone()[0]
        cur.execute(
            "INSERT INTO follow_history (account_id, username, full_name, action) VALUES (%s, %s, %s, 'unfollow')",
            (account_id, username, full_name)
        )
        cur.execute("DELETE FROM current_follows WHERE username = %s AND account_id = %s", (username, account_id))
        print(f"Unfollowed: {username}")

    conn.commit()
    cur.close()

def main():
    conn = connect_postgres()
    username, password, account_id = get_account_choice(conn)
    if not username or not password:
        return

    cl = login_to_instagram(username, password)
    if not cl:
        return

    update_follow_data(cl, conn, account_id)

    conn.close()
    print("✅ Done!")

if __name__ == "__main__":
    main()



















# pip install instagrapi psycopg2-binary 
# pip install pillow



