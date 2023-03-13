#include <iostream>
#include <string>
#include <cmath>
#include <Windows.h>
using namespace std;

extern "C" {
    void first(void);
    void second(void);
    float x;
    float a;
    float y;
    float c;
}

double _first(float x, float a) {
    return (((3 * 4 + 5 * 6) - (exp(x) * a)) / (7 / 2 + 4 / 3 + 12 / 3)) * (16 / 2 * 3 * 6 * cos(a / x));
}

float _second(float n) {
    if (n > 5) {
        return (a/c) - 2*a;
    }
    else {
        return -8;
    }
}

int main() {
    setlocale(LC_ALL, "Rus");
    SetConsoleCP(1251);
    SetConsoleOutputCP(1251);

    float x, a;
    cout << "������� x: ";
    cin >> x;
    cout << "������� a: ";
    cin >> a;
    cout << "������ �1\n";
    for (float i = x; i <= a; i += 0.1) {
        cout << "��� x = " << i << "������� y = " << _first(i, a) << endl;
    }
    cout << "���������� ������:\n";
    for (float i = x; i <= a; i += 0.1) {
        x = i;
        first();
        cout << "��� x = " << x << "������� y = " << y << endl;
    }
    cout << "������ �2";
    for (float i = x; i <= a; i += 0.5) {
        cout << "��� a = " << i << "������� � = " << _second(i) << endl;
    }
    c = 1;
    cout << "���������� ������:\n";
    for (float i = x; i <= a; i += 0.5) {
        a = i;
        second();
        cout << "��� a = " << a << "������� c = " << c << endl;
    }

    return 0;
}
