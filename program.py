import psycopg2

DB_NAME = "proje"
DB_USER = "postgres"
DB_PASS = "alkadri1"
DB_HOST = "localhost"
DB_PORT = "5432"


MENUS = {"main": ["Staff", "Restaurants", "Food Menu", "Reservation"],
         "staff": ["Add", "Remove", "Update", "Show details", "go back", "show logs"],
         "restaurants": ["Add", "Remove", "Update", "Show details", "go back", "show logs"],
         "food menu": ["Add", "Remove", "Update", "Show details", "go back", "show logs"],
         "reservation": ["Add", "Remove", "Update", "Show details", "go back", "show logs"]
         }


class Menu:
    def __init__(self):
        self.current_menu = "main"

    def get_user_selection(self):
        if self.current_menu == "main":
            inp = int(input("Select a menu: "))
            if inp == 1:
                self.current_menu = "staff"
            elif inp == 2:
                self.current_menu = "restaurants"
            elif inp == 3:
                self.current_menu = "food menu"
            elif inp == 4:
                self.current_menu = "reservation"

        elif self.current_menu == "staff":
            inp = int(input("Select a selection: "))
            if inp == 1:
                conn = psycopg2.connect(database=DB_NAME, user=DB_USER,
                                        password=DB_PASS, host=DB_HOST,
                                        port=DB_PORT)

                cur = conn.cursor()
                user_input_id = int(input("Enter staff id: "))
                user_input_salary = int(input("Enter salary: "))
                user_input_work_hours = int(input("Eneter work hours: "))
                cur.execute("INSERT INTO staff (person_id, salary, work_hours) VALUES ({}, {}, {})".format(user_input_id, user_input_salary, user_input_work_hours))
                conn.commit()
                conn.close()
            elif inp == 2:
                conn = psycopg2.connect(database=DB_NAME, user=DB_USER,
                                        password=DB_PASS, host=DB_HOST,
                                        port=DB_PORT)

                cur = conn.cursor()
                user_input_id = int(input("Enter staff id: "))
                cur.execute(
                    "DELETE FROM staff WHERE person_id={}".format(user_input_id))
                conn.commit()
                conn.close()
                pass
            elif inp == 3:
                conn = psycopg2.connect(database=DB_NAME, user=DB_USER,
                                        password=DB_PASS, host=DB_HOST,
                                        port=DB_PORT)
                cur = conn.cursor()
                user_input_id = int(input("Enter id you want to update: "))
                new_salary = int(input("Enter salary: "))
                new_work_hours = int(input("New work hours: "))

                cur.execute("UPDATE staff set salary = {} WHERE person_id = {}".format(new_salary, user_input_id))
                cur.execute("UPDATE staff set work_hours = {} WHERE person_id = {}".format(new_work_hours, user_input_id))
                conn.commit()
                # print("Total row affected  {}".format(cur.rowcount))
                pass
            elif inp == 4:
                conn = psycopg2.connect(database=DB_NAME, user=DB_USER,
                                        password=DB_PASS, host=DB_HOST,
                                        port=DB_PORT)
                cur = conn.cursor()
                cur.execute("SELECT * FROM staff")
                rows = cur.fetchall()
                for data in rows:
                    print("person_id: {}, salary: {}, work_hours: {}".format(data[0], data[1], data[2]))

                conn.close()
            elif inp == 5:
                self.current_menu = "main"

            elif inp == 6:
                conn = psycopg2.connect(database=DB_NAME, user=DB_USER,
                                        password=DB_PASS, host=DB_HOST,
                                        port=DB_PORT)
                cur = conn.cursor()
                cur.execute("SELECT * FROM staff_log")
                rows = cur.fetchall()
                for data in rows:
                    print("log_id: {} id: {} old_salary: {} new_salary: {} old_work_hours: {} new_work_hours: {}".format(data[0], data[1], data[2], data[3], data[4], data[5], data[6]))


        elif self.current_menu == "restaurants":
            inp = int(input("Select a selection: "))
            if inp == 1:
                conn = psycopg2.connect(database=DB_NAME, user=DB_USER,
                                        password=DB_PASS, host=DB_HOST,
                                        port=DB_PORT)

                cur = conn.cursor()
                user_input_id = int(input("Enter staff id: "))
                user_input_name = input("Enter name")
                user_input_work_hours = int(input("Eneter work hours: "))
                cur.execute(
                    "INSERT INTO restaurant (restaurant_id, restaurant_name, work_hours) VALUES ({}, '{}', {})".format(user_input_id,
                                                                                                                       user_input_name,
                                                                                                                    user_input_work_hours))
                conn.commit()
                conn.close()
                pass
            elif inp == 2:
                conn = psycopg2.connect(database=DB_NAME, user=DB_USER,
                                        password=DB_PASS, host=DB_HOST,
                                        port=DB_PORT)

                cur = conn.cursor()
                user_input_id = int(input("Enter restaurant id: "))
                cur.execute(
                    "DELETE FROM restaurant WHERE restaurant_id={}".format(user_input_id))
                conn.commit()
                conn.close()
                pass
            elif inp == 3:
                conn = psycopg2.connect(database=DB_NAME, user=DB_USER,
                                        password=DB_PASS, host=DB_HOST,
                                        port=DB_PORT)
                cur = conn.cursor()
                user_input_id = int(input("Enter id you want to update: "))
                user_input_name = input("Enter name: ")
                user_input_work_hours = int(input("New work hours: "))

                cur.execute("UPDATE restaurant set restaurant_name = '{}' WHERE restaurant_id = {}".format(user_input_name, user_input_id))
                cur.execute(
                    "UPDATE restaurant set twork_hours = {} WHERE twork_hours = {}".format(user_input_work_hours, user_input_id))
                conn.commit()
                pass
            elif inp == 4:
                conn = psycopg2.connect(database=DB_NAME, user=DB_USER,
                                        password=DB_PASS, host=DB_HOST,
                                        port=DB_PORT)
                cur = conn.cursor()
                cur.execute("SELECT * FROM restaurant")
                rows = cur.fetchall()
                for data in rows:
                    print("restaurant_id: {}, restaurant_name: {}, work_hours: {}".format(data[0], data[1], data[2]))

                conn.close()
            elif inp == 5:
                self.current_menu = "main"
            elif inp == 6:
                conn = psycopg2.connect(database=DB_NAME, user=DB_USER,
                                        password=DB_PASS, host=DB_HOST,
                                        port=DB_PORT)
                cur = conn.cursor()
                cur.execute("SELECT * FROM resturant_log")
                rows = cur.fetchall()
                for data in rows:
                    print("log_id: {} id: {} old: {} new: {} time: {}".format(data[0], data[1], data[2], data[3], data[4]))

        elif self.current_menu == "food menu":
            inp = int(input("Select a selection: "))
            if inp == 1:
                conn = psycopg2.connect(database=DB_NAME, user=DB_USER,
                                        password=DB_PASS, host=DB_HOST,
                                        port=DB_PORT)

                cur = conn.cursor()
                user_input_r_id = int(input("Enter restaurant id: "))
                user_input_m_id = int(input("Enter menu id: "))
                user_input_cuisine = input("Eneter cuisine(menu): ")
                cur.execute(
                    "INSERT INTO menu (restaurant_id, menu_id, menus) VALUES ({}, {}, '{}')".format(
                        user_input_r_id,
                        user_input_m_id,
                        user_input_cuisine))
                conn.commit()
                conn.close()
            elif inp == 2:
                conn = psycopg2.connect(database=DB_NAME, user=DB_USER,
                                        password=DB_PASS, host=DB_HOST,
                                        port=DB_PORT)

                cur = conn.cursor()
                user_input_id = int(input("Enter restaurant id: "))
                cur.execute(
                    "DELETE FROM menu WHERE menu_id={}".format(user_input_id))
                conn.commit()
                conn.close()
            elif inp == 3:
                conn = psycopg2.connect(database=DB_NAME, user=DB_USER,
                                        password=DB_PASS, host=DB_HOST,
                                        port=DB_PORT)
                cur = conn.cursor()
                user_input_id = int(input("Enter id you want to update: "))
                user_input_menu = input("Enter menu: ")
                cur.execute(
                    "UPDATE menu set menus = '{}' WHERE menu_id = {}".format(user_input_menu, user_input_id))
                conn.commit()
            elif inp == 4:
                conn = psycopg2.connect(database=DB_NAME, user=DB_USER,
                                        password=DB_PASS, host=DB_HOST,
                                        port=DB_PORT)
                cur = conn.cursor()
                cur.execute("SELECT * FROM staff")
                rows = cur.fetchall()
                for data in rows:
                    print("restaurant_id: {}, menu_id: {}, menus: {}".format(data[0], data[1], data[2]))

                conn.close()
            elif inp == 5:
                self.current_menu = "main"

            elif inp == 6:
                conn = psycopg2.connect(database=DB_NAME, user=DB_USER,
                                        password=DB_PASS, host=DB_HOST,
                                        port=DB_PORT)
                cur = conn.cursor()
                cur.execute("SELECT * FROM menu_log")
                rows = cur.fetchall()
                for data in rows:
                    print("log_id: {} menu_id: {} old: {} new: {} time: {}".format(data[0], data[1], data[2], data[3], data[4]))

        elif self.current_menu == "reservation":
            inp = int(input("Select a selection: "))
            if inp == 1:
                conn = psycopg2.connect(database=DB_NAME, user=DB_USER,
                                        password=DB_PASS, host=DB_HOST,
                                        port=DB_PORT)

                cur = conn.cursor()
                user_input_r_id = int(input("Enter restaurant id: "))
                user_input_c_id = int(input("Enter costumer id: "))
                user_input_rsr_id = int(input("Enter reservation id: "))
                user_input_rsr_time = input("Enter reservation time: ")
                cur.execute(
                    "INSERT INTO reservation (restaurant_id, costumer_id, reservation_id, reservation_time) VALUES ({}, {}, {}, '{}')".format(
                        user_input_r_id,
                        user_input_c_id,
                        user_input_rsr_id,
                        user_input_rsr_time))
                conn.commit()
                conn.close()
            elif inp == 2:
                conn = psycopg2.connect(database=DB_NAME, user=DB_USER,
                                        password=DB_PASS, host=DB_HOST,
                                        port=DB_PORT)

                cur = conn.cursor()
                user_input_id = int(input("Enter reservation id: "))
                cur.execute(
                    "DELETE FROM reservation WHERE reservation_id={}".format(user_input_id))
                conn.commit()
                conn.close()
            elif inp == 3:
                conn = psycopg2.connect(database=DB_NAME, user=DB_USER,
                                        password=DB_PASS, host=DB_HOST,
                                        port=DB_PORT)
                cur = conn.cursor()
                reservation_id = int(input("Enter id you want to update: "))
                user_input_time = input("Enter reservation time: ")
                cur.execute(
                    "UPDATE reservation set reservation_time = '{}' WHERE reservation_id = {}".format(user_input_time, reservation_id))

                conn.commit()
            elif inp == 4:
                conn = psycopg2.connect(database=DB_NAME, user=DB_USER,
                                        password=DB_PASS, host=DB_HOST,
                                        port=DB_PORT)
                cur = conn.cursor()
                cur.execute("SELECT * FROM reservation")
                rows = cur.fetchall()
                for data in rows:
                    print("restaurant_id: {}, costumer_id: {}, reservation_id: {}, reservation_time: {}".format(data[0], data[1], data[2], data[3]))

                conn.close()
            elif inp == 5:
                self.current_menu = "main"

            elif inp == 6:
                conn = psycopg2.connect(database=DB_NAME, user=DB_USER,
                                        password=DB_PASS, host=DB_HOST,
                                        port=DB_PORT)
                cur = conn.cursor()
                cur.execute("SELECT * FROM reservation_log")
                rows = cur.fetchall()
                for data in rows:
                    print("log_id: {} reservation_id: {} old: {} new: {} time: {}".format(data[0], data[1], data[2], data[3], data[4]))

    def show(self):
        for option in MENUS["{}".format(self.current_menu)]:
            print("{}- {}".format(MENUS["{}".format(self.current_menu)].index(option) + 1, option))


if __name__ == '__main__':
    menu = Menu()
    while True:
        menu.show()
        menu.get_user_selection()
        print("\n")