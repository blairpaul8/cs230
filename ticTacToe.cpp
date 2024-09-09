#include <iostream>
#include <vector>
#include <string>
using namespace std;

class Tictactoe {
	public:
		Tictactoe(int size);
		bool checkRows();
		bool checkColumns();
		bool checkDiagonals();
		bool checkWin();
		int size;
		vector<vector<char>> board; 
};

Tictactoe::Tictactoe(int size) {
	this->size = size;
	board = vector<vector<char>> (size, vector<char> (size, '-'));
}

bool Tictactoe::checkRows() {
	for (int i = 0; i < size; i++) {
		char first = board[i][0];
		int j = 1;
		for ( ;j < size; j++) {
			if (board[i][j] != first) {
				break;
			}
		}
		if (j == size) {
			return true;
		}
	}
	return false;		
}

bool Tictactoe::checkColumns() {
	for (int i = 0; i < size; i++) {
		char first = board[0][i];
		int j = 1;
		for ( ; j < size; j++) {
			if (board[j][i] != first) {
				break;
			}
		}
		if (j == size) {
			return true;
		}
	}
	return false;
}

bool Tictactoe::checkDiagonals() {
	bool diagonalWin = false;
	char firstTop = board[0][0];
	char firstBottom = board[0][size];
	
	int i = 1;
	for ( ; i < size; i++) {
		if (board[i][size - i] != firstTop) {
			break;
		}
	}
	if (i == size) {
		return true;
	}
	
	int j = 1;
	for ( ; j < size; j++) {
		if (board[j][size - j] != firstBottom) {
			break;
		}
	}
	if (j == size) {
		return true;
	}

	return false;
}

bool Tictactoe::checkWin() {
	if (checkRows() == true || checkColumns() == true || checkDiagonals() == true) {
		return true;
	}
	else {
		return false;
	}
}

int main() {
	char input;
	string temp;
	int boardSize;
	int row = 0;

	cout << "Enter the size of the board: ";
	cin >> boardSize;
	cin.ignore();
	cout << row << endl;	
	Tictactoe game = Tictactoe(boardSize);
	while (getline(cin, temp)) {
		for (int i = 0; i < boardSize; i++) {
			game.board[row][i] = temp[i];
			
		}

		for (int i = 0; i < boardSize; i++) {
			for (int j = 0; j < boardSize; j++) {
				cout << game.board[i][j];
			}
			cout << endl;
		}	
		row += 1;
	}

	if (game.checkRows()) {
		cout << "Game is over!" << endl;
	}

	else {
		cout << "Cats Game!" << endl;
	}



	return 0;
}	
