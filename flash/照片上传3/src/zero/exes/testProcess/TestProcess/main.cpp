#include <cstdlib>
#include <iostream>

using namespace std;

int add();

int main(int argc, char *argv[])
{
    string str;
    while(cin>>str){
        if(str=="add"){
            cout<<add();
        }else{
            cout<<"Î´ÖªÃüÁî";
        }
    }
    return EXIT_SUCCESS;
}
int add(){
    int a,b;
    cin>>a>>b;
    return a+b;
}
