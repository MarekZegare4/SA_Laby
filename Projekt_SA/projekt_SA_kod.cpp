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
    double U[dlugSym]={0};
    double Y4[dlugSym]={0};
    double Y3[dlugSym]={0};
    double Y2[dlugSym]={0};
    double Y1[dlugSym]={0};
    double Y[dlugSym]={0};

};


void inicjalizujTablice(tabs& tab){

    for(int i=0; i++; i<dlugSym)
     tab.czas[i] = 2;// krok*i;
    
    tab.U[0] =1; // odp impulsowa
}

void obiekt(tabs& tab ){

    for(int i=0; i<dlugSym -1; i++){
    tab.Y4[i] = (Kp*tab.U[i] - tab.Y3[i]*(a2 + a1*Tp) - tab.Y2[i]*(a1 +Tp) - tab.Y1[i])/(a2*Tp*Ti);
    tab.Y3[i+1] = tab.Y3[i] +h*tab.Y4[i];
    tab.Y2[i+1] = tab.Y2[i] +h*tab.Y3[i];
    tab.Y1[i+1] = tab.Y1[i] +h*tab.Y2[i];
    tab.Y[i+1] = tab.Y[i] +h*tab.Y1[i] + (h*h/2)*tab.Y2[i] +(h*h*h/6)*tab.Y3[i] +(h*h*h*h/24)*tab.Y4[i];
    tab.czas[i+1] = tab.czas[i] +h; //O CO CHODZIIIIIIi
    }

}


int zapisz_plik(tabs tab, std::ofstream &plik){

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
    

    obiekt(tab);
    
    zapisz_plik(tab,plik);

    std::cout << "Y      czas\n";
    for(int i=0; i<dlugSym; i++)
        std::cout << tab.Y[i]<<"        " <<tab.U[i]<<'\n';
    

    return 0;
}