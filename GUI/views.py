import sys
from PyQt5.QtWidgets import QApplication, QWidget, QVBoxLayout, QPushButton, QTableWidget, QTableWidgetItem, QHBoxLayout, QLabel
import pyodbc

class ViewPage(QWidget):
    def __init__(self, cursor):
        super(ViewPage, self).__init__()

        self.setWindowTitle('Views Page')
        self.setGeometry(200, 200, 600, 400)

        self.cursor = cursor

        self.layout = QVBoxLayout()

        self.create_view_table('User_Profile_View', self.execute_view('User_Profile_View'))
        self.create_view_table('Product_Details_View', self.execute_view('Product_Details_View'))
        self.create_view_table('User_Message_History_View', self.execute_view('User_Message_History_View'))

        self.setLayout(self.layout)

        self.resize(800, 600)
        self.setStyleSheet("background-color: rgb(97, 217, 193);")

    def create_view_table(self, view_name, data):
        view_layout = QVBoxLayout()

        view_label = QLabel(view_name)
        view_layout.addWidget(view_label)

        table = QTableWidget(self)
        table.setRowCount(len(data))
        table.setColumnCount(len(data[0]))

        column_names = [column[0] for column in self.cursor.description]
        table.setHorizontalHeaderLabels(column_names)

        for i, row in enumerate(data):
            for j, item in enumerate(row):
                table.setItem(i, j, QTableWidgetItem(str(item)))

        view_layout.addWidget(table)
        self.layout.addLayout(view_layout)
        table.setStyleSheet("background-color:  rgb(152, 206, 220);")

    def execute_view(self, view_name):
        try:
            self.cursor.execute(f"SELECT * FROM {view_name}")
            result = self.cursor.fetchall()
            return result
        except pyodbc.Error as ex:
            print(f"Error: {ex}")
            return []

if __name__ == '__main__':
    app = QApplication(sys.argv)
    window = ViewPage() 
    window.show()
    sys.exit(app.exec_())
