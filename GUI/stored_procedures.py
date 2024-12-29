import sys
from PyQt5.QtWidgets import QWidget, QVBoxLayout, QHBoxLayout, QPushButton, QLabel, QLineEdit, QSpacerItem, QSizePolicy
import pyodbc

class ProcedurePage(QWidget):
    def __init__(self, cursor):
        super(ProcedurePage, self).__init__()

        self.setWindowTitle('Procedure Page')
        self.setGeometry(200, 200, 400, 200)

        self.cursor = cursor

        layout = QVBoxLayout()

        input_layout_1, self.product_group_id_input, execute_button_1 = self.create_widgets_update_product_group_description()

        layout.addLayout(input_layout_1)
        layout.addItem(QSpacerItem(8, 10))
        layout.addWidget(execute_button_1)

        layout.addItem(QSpacerItem(8, 40))

        input_layout_2, execute_button_2 = self.create_widgets_send_message()

        layout.addLayout(input_layout_2)
        layout.addItem(QSpacerItem(8, 10))
        layout.addWidget(execute_button_2)

        layout.addItem(QSpacerItem(8, 40))


        input_layout_3, execute_button_3 = self.create_widgets_update_product_price()


        layout.addLayout(input_layout_3)
        layout.addItem(QSpacerItem(8, 10))
        layout.addWidget(execute_button_3)

        self.status_label = QLabel('')
        layout.addWidget(self.status_label)

        self.setLayout(layout)

        self.resize(800, 400)
        self.setStyleSheet("background-color: rgb(97, 217, 193);")

    def create_widgets_update_product_group_description(self):
        input_layout = QHBoxLayout()

        label = QLabel('Product Group ID:')
        input_field = QLineEdit(self)
        input_field.setStyleSheet("background-color: rgb(152, 206, 220);")
        execute_button = QPushButton('Execute Update Product Group Description', self)
        execute_button.clicked.connect(lambda: self.execute_procedure_update_product_group_description())
        execute_button.setStyleSheet("background-color: rgb(152, 206, 220);")

        input_layout.addWidget(label)
        input_layout.addWidget(input_field)

        return input_layout, input_field, execute_button

    def create_widgets_send_message(self):
        input_layout = QHBoxLayout()

        label1 = QLabel('User ID 1:')
        label2 = QLabel('User ID 2:')
        label3 = QLabel('Product ID:')
        label4 = QLabel('Message Text:')

        self.user_id_1_input = QLineEdit(self)
        self.user_id_1_input.setStyleSheet("background-color: rgb(152, 206, 220);")
        self.user_id_2_input = QLineEdit(self)
        self.user_id_2_input.setStyleSheet("background-color: rgb(152, 206, 220);")
        self.product_id_input = QLineEdit(self)
        self.product_id_input.setStyleSheet("background-color: rgb(152, 206, 220);")
        self.message_text_input = QLineEdit(self)
        self.message_text_input.setStyleSheet("background-color: rgb(152, 206, 220);")

        execute_button = QPushButton('Execute Send Message', self)
        execute_button.setStyleSheet("background-color: rgb(152, 206, 220);")
        execute_button.clicked.connect(lambda: self.execute_procedure_send_message())

        input_layout.addWidget(label1)
        input_layout.addWidget(self.user_id_1_input)
        input_layout.addWidget(label2)
        input_layout.addWidget(self.user_id_2_input)
        input_layout.addWidget(label3)
        input_layout.addWidget(self.product_id_input)
        input_layout.addWidget(label4)
        input_layout.addWidget(self.message_text_input)

        return input_layout, execute_button


    def create_widgets_update_product_price(self):
        input_layout = QHBoxLayout()

        label1 = QLabel('Product ID:')
        label2 = QLabel('New Price:')

        self.product_id_input_price = QLineEdit(self)
        self.product_id_input_price.setStyleSheet("background-color: rgb(152, 206, 220);")
        self.new_price_input = QLineEdit(self)
        self.new_price_input.setStyleSheet("background-color: rgb(152, 206, 220);")

        execute_button = QPushButton('Execute Update Product Price', self)
        execute_button.setStyleSheet("background-color: rgb(152, 206, 220);")
        execute_button.clicked.connect(lambda: self.execute_procedure_update_product_price())

        input_layout.addWidget(label1)
        input_layout.addWidget(self.product_id_input_price)
        input_layout.addWidget(label2)
        input_layout.addWidget(self.new_price_input)

        return input_layout, execute_button

    def execute_procedure_update_product_group_description(self):
        input_text = self.product_group_id_input.text()

        try:
            input_value = int(input_text)
            self.cursor.execute(f"EXEC UpdateProductGroupDescription @ProductGroupId=?", input_value)
            self.cursor.commit()
            self.status_label.setText('Stored procedure Update Product Group Description executed successfully.')
        except ValueError:
            self.status_label.setText('Invalid input. Please enter a valid value.')
        except pyodbc.Error as ex:
            self.status_label.setText(f'Error: {ex}')

    def execute_procedure_send_message(self):
        input_text1 = self.user_id_1_input.text()
        input_text2 = self.user_id_2_input.text()
        input_text3 = self.product_id_input.text()
        input_text4 = self.message_text_input.text()

        try:
            input_value1 = int(input_text1)
            input_value2 = int(input_text2)
            input_value3 = int(input_text3)

            self.cursor.execute("EXEC SendMessage @UserId1=?, @UserId2=?, @ProductId=?, @MessageText=?",
                                input_value1, input_value2, input_value3, input_text4)

            self.cursor.commit()
            self.status_label.setText('Stored procedure Send Message executed successfully.')
        except ValueError:
            self.status_label.setText('Invalid input. Please enter valid values.')
        except pyodbc.Error as ex:
            self.status_label.setText(f'Error: {ex}')


    def execute_procedure_update_product_price(self):
        input_text1 = self.product_id_input_price.text()
        input_text2 = self.new_price_input.text()

        try:
            input_value1 = int(input_text1)
            input_value2 = float(input_text2)

            self.cursor.execute("EXEC UpdateProductPrice @ProductId=?, @NewPrice=?", input_value1, input_value2)
            self.cursor.commit()
            self.status_label.setText('Stored procedure Update Product Price executed successfully.')
        except ValueError:
            self.status_label.setText('Invalid input. Please enter valid values.')
        except pyodbc.Error as ex:
            self.status_label.setText(f'Error: {ex}')