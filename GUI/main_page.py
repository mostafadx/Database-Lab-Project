import sys
from PyQt5.QtWidgets import QApplication, QWidget, QVBoxLayout, QPushButton
from PyQt5.QtGui import QIcon
from functions import FunctionPage
from views import ViewPage
from table import TablePage
from stored_procedures import ProcedurePage
from connect_to_database import connect_database

class MainWindow(QWidget):
    def __init__(self):
        super(MainWindow, self).__init__()

        self.setWindowTitle('Database Operations')
        self.setGeometry(100, 100, 400, 200)

        layout = QVBoxLayout()

        tables_button = self.create_button('Tables', 'icons/tables.png', self.show_tables)
        functions_button = self.create_button('Functions', 'icons/functions.png', self.show_functions)
        views_button = self.create_button('Views', 'icons/views.png', self.show_views)
        procedures_button = self.create_button('Procedures', 'icons/procedures.png', self.show_procedures)

        layout.addWidget(tables_button)
        layout.addWidget(functions_button)
        layout.addWidget(views_button)
        layout.addWidget(procedures_button)

        self.setLayout(layout)

        self.setStyleSheet("background-color: rgb(97, 217, 193);")

    def create_button(self, text, icon_path, on_click):
        button = QPushButton(text, self)
        button.setIcon(QIcon(icon_path))
        button.clicked.connect(on_click)
        button.setStyleSheet(
            """
            QPushButton {
                font-size: 14px;
                padding: 8px;
                margin: 5px;
                border: 2px solid #4CAF50;
                border-radius: 8px;
                color: Black;
                background-color: rgb(152, 206, 220);
            }
            
            QPushButton:hover {
                background-color: #45a049;
            }
            """
        )
        return button

    def show_functions(self):
        print("Functions button clicked")
        self.function_page = FunctionPage(self.cursor)
        self.function_page.show()

    def show_views(self):
        print("Views button clicked")
        self.views = ViewPage(self.cursor)
        self.views.show()

    def show_procedures(self):
        print("Procedures button clicked")
        self.procedure_page = ProcedurePage(self.cursor)
        self.procedure_page.show()

    def show_tables(self):
        print("Tables button clicked")
        self.table_page = TablePage()
        self.table_page.set_cursor(self.cursor)
        self.table_page.show()

    def set_cursor(self, cursor):
        self.cursor = cursor


if __name__ == '__main__':
    app = QApplication(sys.argv)
    window = MainWindow()
    window.set_cursor(connect_database('.', 'ShopApp', 'sa', 'Password', '17'))  # driver version
    window.show()
    sys.exit(app.exec_())
