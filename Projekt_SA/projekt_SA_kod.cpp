#include <iostream>
#include <fstream>

typedef double liczba;



const  liczba h = 0.000001;
const double czasKoniec = 1;
const unsigned int dlugSym = int(czasKoniec/h +1); 

const liczba Tp = 0.002249;
const liczba Ti =0.00073;
const liczba Kp = 2.483;
const liczba a1 =0.00069312;
const liczba a2 = 0.00000026991;
const liczba To =0.00021;

const  int opoz = int(To/h);

// const liczba Tp = 0.21;
// const liczba Ti =0.0031;
// const liczba Kp = 1.5;
// const liczba a1 =0.001;
// const liczba a2 = 0.021;
// const liczba To =1;


// double gug[1000000] = {0};

struct tabs{
    liczba* czas {new liczba[dlugSym]};
    liczba* R {new liczba[dlugSym]};
     liczba* Yczuj {new liczba[dlugSym]};
     liczba* Y {new liczba[dlugSym]};
     liczba* e {new liczba[dlugSym]};
     liczba* U {new liczba[dlugSym]};
     liczba* Uster {new liczba[dlugSym]};

};


void inicjalizujTablice(tabs& tab);

liczba obiekt(liczba syg);

int zapiszPlik(tabs tab, std::ofstream & plik);


void inicjalizujTablice(tabs& tab){
    for(int i=0; i<dlugSym; i++){
        
        tab.czas[i] = h*i;
        tab.R[i] =1;
         
        }  
   // odp impuslowa
}


void czyscTablice(tabs& tab){

delete[] tab.czas;
delete[] tab.R;
delete[] tab.Yczuj;
delete[] tab.Y;
delete[] tab.U;
delete[] tab.Uster;
delete[] tab.e;
 

}

liczba obiekt(liczba syg ){

    static liczba Y,Y1,Y2,Y3,Y4;
    static liczba Y1s, Y2s, Y3s;

    Y4 = ((Kp/Ti)*syg - Y3s*(a2 + a1*Tp) - Y2s*(a1 +Tp) - Y1s)/(a2*Tp);
    Y3 += Y4*h;
    Y2 += (Y3s*h +(h*h/2)*Y4);
    Y1 += (Y2s*h +(h*h/2)*Y3s + (h*h*h/6)*Y4);

    Y += (h*Y1s + (h*h/2)*Y2s +(h*h*h/6)*Y3s+(h*h*h*h/24)*Y4);

    Y1s = Y1;
    Y2s = Y2;
    Y3s = Y3;

    return Y;

}

liczba P(liczba syg){
    const liczba P = 0.04;
    return syg*P;
}

liczba nasycenie(liczba syg){
    const liczba gora = 5;
    const liczba dol =-5;
    //liczba wyj =0;

    // wyj =(syg > gora ?  gora : syg);
    // wyj =(syg < dol ? dol :  syg);

    if(syg >gora)
        return gora;

    if (syg <dol)
        return dol;

    return syg;
};


liczba czujnik(liczba syg){

    static liczba Y1,Y;
    static liczba Y1s, Ys;

    Y1 = (syg - Ys)/(0.05*Tp);
    Y += Y1s*h;
    Y1s = Y1;
    Ys = Y;

    return Y;

}




int zapiszPlik(tabs tab, std::ofstream &plik){

    plik<<"Y,U,czas"<<std::endl;
    plik <<h <<',' <<czasKoniec <<','<<Tp<<std::endl;
    plik <<Ti <<',' <<Kp <<','<<a1<<std::endl;
    plik <<a2 <<',' <<To <<','<<0<<std::endl;

    for(int i=0; i<dlugSym;i++)
        plik<<tab.Y[i] <<',' <<tab.Uster[i] <<',' << tab.czas[i] <<','<<std::endl;
    plik.close();

    return 0;
}


void obliczenia(tabs& tab){
    liczba syg =0;

    for (int i=0; i<dlugSym -1-opoz*5; i++) {
        
        tab.e[i] = tab.R[i] -tab.Yczuj[i] ;
        tab.U[i] = P(tab.e[i]);
        tab.Uster[i] = nasycenie(tab.U[i]);     
        tab.Y[i+1 +opoz*5] = obiekt(tab.Uster[i]);
        tab.Yczuj[i+1 +opoz] = czujnik(tab.Y[i]);
                
         }
    return;
}


int main(){

    tabs tab;  
    std::ofstream plik("Wyjscie_symulacji.csv");

    inicjalizujTablice(tab);
    
    obliczenia(tab);
    
    zapiszPlik(tab,plik);

    czyscTablice(tab);
    
    return 0;
}