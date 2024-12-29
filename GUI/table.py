from PyQt5.QtWidgets import QWidget, QVBoxLayout, QListWidget, QTableWidget, QTableWidgetItem

class TablePage(QWidget):
    def __init__(self):
        super(TablePage, self).__init__()

        self.setWindowTitle('Tables Page')

        layout = QVBoxLayout()

        self.table_list_widget = QListWidget(self)
        self.table_list_widget.itemClicked.connect(self.show_table_data)

        self.table_widget = QTableWidget(self)

        layout.addWidget(self.table_list_widget)
        layout.addWidget(self.table_widget)

        self.setLayout(layout)
        self.resize(800, 450)

        self.setStyleSheet("background-color: rgb(97, 217, 193);")
        self.table_list_widget.setStyleSheet("background-color:  rgb(152, 206, 220);")
        self.table_widget.setStyleSheet("background-color:  rgb(152, 206, 220);")
        

    def set_cursor(self, cursor):
        self.cursor = cursor
        self.populate_table_list()

    def populate_table_list(self):
        self.cursor.execute("SELECT table_name FROM INFORMATION_SCHEMA.TABLES WHERE table_type = 'BASE TABLE'")
        tables = self.cursor.fetchall()

        for table in tables:
            table_name = table[0]
            self.table_list_widget.addItem(table_name)

    def show_table_data(self, item):
        table_name = item.text()

    
        self.cursor.execute(f"SELECT column_name FROM INFORMATION_SCHEMA.COLUMNS WHERE table_name = '{table_name}'")
        columns = [column[0] for column in self.cursor.fetchall()]

        self.cursor.execute(f"SELECT * FROM [{table_name}]")
        data = self.cursor.fetchall()

        self.table_widget.setColumnCount(len(columns))
        self.table_widget.setHorizontalHeaderLabels(columns)

        self.table_widget.setRowCount(len(data))
        for row_num, row_data in enumerate(data):
            for col_num, col_data in enumerate(row_data):
                item = QTableWidgetItem(str(col_data))
                self.table_widget.setItem(row_num, col_num, item)


