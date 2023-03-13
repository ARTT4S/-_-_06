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
    cout << "Введите x: ";
    cin >> x;
    cout << "Введите a: ";
    cin >> a;
    cout << "Задача №1\n";
    for (float i = x; i <= a; i += 0.1) {
        cout << "При x = " << i << "функция y = " << _first(i, a) << endl;
    }
    cout << "Результаты сборки:\n";
    for (float i = x; i <= a; i += 0.1) {
        x = i;
        first();
        cout << "При x = " << x << "функция y = " << y << endl;
    }
    cout << "Задача №2";
    for (float i = x; i <= a; i += 0.5) {
        cout << "При a = " << i << "функция с = " << _second(i) << endl;
    }
    c = 1;
    cout << "Результаты сборки:\n";
    for (float i = x; i <= a; i += 0.5) {
        a = i;
        second();
        cout << "При a = " << a << "функция c = " << c << endl;
    }

    return 0;
}
