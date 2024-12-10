#include <iostream>
using namespace std;

struct Mystruct {
	long value;
	char key[21];
};

int main() {
	Mystruct a = new Mystruct;

	cout << sizeof(a) << endl;

}
