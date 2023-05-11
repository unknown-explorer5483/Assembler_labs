#include <iostream>
#include <string.h>
extern "C++" char* str1(const char* n);
extern "C++" void print1(char* n);
extern "C++" void printdebug(int number,bool unique);
using namespace std;

int main() {
    char string[256];
    cout << "Enter string:\n";
    cin.getline(string,sizeof(string));
    strcat(string, " ");
    str1(string);
    return 0;
}

void print1(char* output) 
{ 
    cout << "Unique words:\n";
    std::cout << output << "\n";
} 

void printdebug(int number,bool unique) 
{ 
    if (!unique) 
    {
        cout << "Word number " << number+1 << " is unique compared to next words.\n";
    } 
    else
    {
        cout << "Word number " << number+1 << " is not unique compared to next words.\n";
    }
} 


