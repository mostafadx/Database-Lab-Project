from PyQt5.QtWidgets import QWidget, QVBoxLayout, QPushButton, QLabel, QLineEdit, QTextEdit, QHBoxLayout, QTableWidget, QTableWidgetItem
import pyodbc

class FunctionPage(QWidget):
    def __init__(self, cursor):
        super(FunctionPage, self).__init__()

        self.setWindowTitle('Functions Page')
        self.setGeometry(200, 200, 500, 300)

        self.cursor = cursor

        layout = QVBoxLayout()

        self.create_function_widget('Check National Code', 'National Code:', 'national_code_input', 'Result:', 'national_code_output', layout)
        run_button_1 = QPushButton('Run Check National Code', self)
        run_button_1.clicked.connect(self.run_check_national_code)
        run_button_1.setStyleSheet("background-color:  rgb(152, 206, 220);")
        layout.addWidget(run_button_1)
        
        self.create_function_widget('Total Product Price Of User', 'User ID:', 'user_id_input', 'Result:', 'total_price_output', layout)
        run_button_2 = QPushButton('Run Total Product Price Of User', self)
        run_button_2.clicked.connect(self.run_total_product_price_of_user)
        run_button_2.setStyleSheet("background-color:  rgb(152, 206, 220);")
        layout.addWidget(run_button_2)

        self.create_function_widget('Get Product Messages', 'Product ID:', 'product_id_input', 'Result:', 'product_messages_output', layout)
        run_button_3 = QPushButton('Run Get Product Messages', self)
        run_button_3.clicked.connect(self.run_get_product_messages)
        run_button_3.setStyleSheet("background-color:  rgb(152, 206, 220);")
        layout.addWidget(run_button_3)

        self.setLayout(layout)

        self.resize(800, 450)
        self.setStyleSheet("background-color: rgb(97, 217, 193);")

    def create_function_widget(self, function_name, input_label_text, input_name, output_label_text, output_name, layout):
        function_layout = QHBoxLayout()

        input_label = QLabel(input_label_text)
        input_field = QLineEdit(self)
        input_field.setStyleSheet("background-color: rgb(152, 206, 220);")

        output_label = QLabel(output_label_text)
        output_field = QTextEdit(self)
        output_field.setStyleSheet("background-color:  rgb(152, 206, 220);")
        output_field.setReadOnly(True)

        function_layout.addWidget(QLabel(function_name))
        function_layout.addWidget(input_label)
        function_layout.addWidget(input_field)
        function_layout.addWidget(output_label)
        function_layout.addWidget(output_field)

        setattr(self, input_name, input_field)
        setattr(self, output_name, output_field)

        layout.addLayout(function_layout)

    def run_check_national_code(self):
        national_code_text = self.national_code_input.text()
        result = self.check_national_code(national_code_text)
        self.national_code_output.setText(f'Result: {"Valid" if result else "Invalid"}')

    def run_total_product_price_of_user(self):
        user_id_text = self.user_id_input.text()
        result = self.total_product_price_of_user(int(user_id_text))
        self.total_price_output.setText(f'Result: {result}')

    def run_get_product_messages(self):
        product_id_text = self.product_id_input.text()
        result = self.get_product_messages(int(product_id_text))
        self.display_product_messages(result)

    def check_national_code(self, national_code):
        try:
            self.cursor.execute("SELECT dbo.CheckNationalCode(?) AS Result", national_code)
            result = self.cursor.fetchone().Result
            return result
        except pyodbc.Error as ex:
            print(f"Error: {ex}")
            return False

    def total_product_price_of_user(self, user_id):
        try:
            self.cursor.execute("SELECT dbo.TotalProductPriceOfUser(?) AS Result", user_id)
            result = self.cursor.fetchone().Result
            return result
        except pyodbc.Error as ex:
            print(f"Error: {ex}")
            return 0

    def get_product_messages(self, product_id):
        try:
            self.cursor.execute("SELECT * FROM dbo.GetProductMessages(?)", product_id)
            result = self.cursor.fetchall()
            return result
        except pyodbc.Error as ex:
            print(f"Error: {ex}")
            return []

    def display_product_messages(self, messages):
        message_text = "\n".join([f'From User ID {message[1]}: {str(message[4])}' for message in messages])
        self.product_messages_output.setText(message_text)

