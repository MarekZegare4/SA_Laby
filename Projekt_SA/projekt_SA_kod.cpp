#include <iostream>
#include <fstream>

const  double h = 0.01;
const int czasKoniec = 10;
const unsigned int dlugSym = int(czasKoniec/h +1); 

const double Tp = 1;
const double Ti =1;
const double Kp = 1;
const double a1 =1;
const double a2 = 1;
const double To =1;


struct tabs{
    double czas[dlugSym] ={0};
    double U[dlugSym]={2,1};
    double syg[dlugSym] = {0};
    double Y[dlugSym]={0};
};


void inicjalizujTablice(tabs& tab);

void obiekt(double& syg, double& Y);

int zapiszPlik(tabs tab, std::ofstream & plik);


void inicjalizujTablice(tabs& tab){
    for(int i=0; i<dlugSym; i++)
        tab.czas[i] = h*i;// krok*i;}
    tab.U[0] =1; // odp impulsowa
}


void obiekt(double& syg, double& Y ){

    static double Y1,Y2,Y3,Y4,Ys;

    Y4 = (Kp*syg - Y3*(a2 + a1*Tp) - Y2*(a1 +Tp) - Y1)/(a2*Tp*Ti);
    Y3 += Y4*h;
    Y2 += Y3*h +(h*h/2)*Y2;
    Y1 += Y2*h +(h*h/2)*Y3 + (h*h*h/6)*Y4;

    Y = Ys+ h*Y1 + (h*h/2)*Y2 +(h*h*h/6)*Y3+(h*h*h*h/24)*Y4;
    Ys = Y;


}


int zapiszPlik(tabs tab, std::ofstream &plik){

    plik<<"Y,U,czas"<<std::endl;

    for(int i=0; i<dlugSym;i++)
        plik<<tab.Y[i] <<',' <<tab.U[i] <<',' << tab.czas[i] <<','<<std::endl;
    plik.close();

    return 0;
}




int main(){

    tabs tab;  
    std::ofstream plik("Wyjscie_symulacji.csv");


    inicjalizujTablice(tab);
    
    for (int i=0; i<dlugSym; i++)       
        obiekt(tab.U[i], tab.Y[i]);
    
    
    zapiszPlik(tab,plik);

    std::cout << "Y      czas\n";
    for(int i=0; i<dlugSym; i++)
        std::cout << tab.Y[i]<<"        " <<tab.czas[i]<<'\n';
    

    return 0;
}