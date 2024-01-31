#include <iostream>
#include <fstream>
#include <cmath>
#include <tuple>


typedef double liczba;


const bool BODE = false;
const  liczba h = 0.0000001;
const double czasKoniec =0.1;
const unsigned int dlugSym = int(czasKoniec/h +1); 

const liczba Tp = 0.002249;
const liczba Ti =0.00073;
const liczba Kp = 2.483;
const liczba a1 =0.00069312;
const liczba a2 = 0.00000026991;
const liczba To =0.00021;

const  int opoz = int(To/h);



struct tabs{
     liczba* czas {new liczba[dlugSym]};
     liczba* R {new liczba[dlugSym]};
     liczba* Yczuj {new liczba[dlugSym]};
     liczba* Y {new liczba[dlugSym]};
     liczba* e {new liczba[dlugSym]};
     liczba* U {new liczba[dlugSym]};
     liczba* Uster {new liczba[dlugSym]}; 
     liczba* Obs{new liczba[dlugSym]};

};



//Inicjalizacja potrzebnych sygnałów, takie jak pobudzenie czy czas
void inicjalizujTablice(tabs& tab,char tryb, liczba freq);


//Zwolnienie pamięci ze sterty
void czyscTablice(tabs& tab);


//Zapis do pliku
int zapiszPlik(tabs tab, std::ofstream & plik);


//Realizacja symulacji obiektu
liczba obiekt(liczba syg);


//Nasycenie w układzie
liczba nasycenie(liczba syg, liczba gora =5 , liczba dol =-5);


//Obserwator stanu
liczba obserwator(liczba syg, liczba Yp);


//Model stanowy przybliżający działanie obiektu BEZ STEROWNIKA P
//w realizacji sterowalnej
liczba modelStanowy(liczba syg);


//Model stanowy w realizacji obserwowalnej
liczba modelStanowyObs(liczba syg);


//Korektor LEAD
liczba LEAD(liczba syg);


//Korektor LAG
liczba LAG(liczba syg);


//Regulator PID
liczba PID(liczba syg);


//Regulator PI
liczba PI(liczba syg);


//Regulator P, potzrebny do stabilizacji układu
liczba P(liczba syg, liczba P =0.03);


//Realizacja czujnika w pętli sprzężenia zwrotnego
liczba czujnik(liczba syg);

//Realizacja obliczeń w pętli dla układu zamkniętego
void obliczenia(tabs& tab);


//Realizacja charakterystyk Bodego
std::tuple<liczba,liczba> Bode(liczba* Y,liczba* R,liczba freq);






void inicjalizujTablice(tabs& tab, char tryb = 's',liczba freq =1){

    int prog = (dlugSym-1)/10;

    if(BODE){
        for(int i=0; i<dlugSym; i++){
            tab.R[i] =sin(h*i*2*M_PI*freq);
            tab.czas[i] = i*h;
            }
        return;
    }

    switch (tryb){

    case 's':

        for(int i=0; i<dlugSym; i++){
            tab.R[i] =1;
            tab.czas[i] = i*h;
            }
        
        return;
        break;

    case 'p':
    

        for(int i=0; i<dlugSym; i++)
            if(i<prog || (i> 2*prog && i< 3*prog )|| (i>4*prog && i< 5*prog)){
                tab.R[i] = 1;
                tab.czas[i] =i*h;
            }
        return;
        break;
    
    case 'r':

        for(int i=0; i<dlugSym; i++){      
           tab.R[i] = i*h;
           tab.czas[i] = i*h;
           }
        
        return;
        break;

    case  'x' : //szum gaussowski

        for(int i=0; i<dlugSym; i++){
            tab.R[i] = -1 + double(2*(rand()/RAND_MAX));
            tab.czas[i] = i*h;
            }
        
        return;
        break;
    
    case  'i' :

        for(int i=0; i<dlugSym; i++)
                tab.czas[i] = i*h;
        tab.R[0] =1;
        return;
        break;

    default :
        for(int i=0; i<dlugSym; i++)
                tab.czas[i] = i*h;
        tab.R[0] =1;
        return;
        break;

    }
    return;
}


void czyscTablice(tabs& tab){

delete[] tab.czas;
delete[] tab.R;
delete[] tab.Yczuj;
delete[] tab.Y;
delete[] tab.U;
delete[] tab.Uster;
delete[] tab.e;
delete[] tab.Obs;
 

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


liczba obserwator(liczba syg, liczba Yp){
    static const liczba a = 1.65*pow(10,9), b =4.85*pow(10,6), c=3012; 
    static const liczba wa =1.64*pow(10,11), wb = 2.52*pow(10,5), wc = 0.153;
    static const liczba l1 = 2.92*pow(10,5), l2 = 5570, l3 = -3.96, l4 = 13.1*pow(10,-3);

    static liczba x1p, x2p, x3p, x4p;
    static liczba x1, x2, x3, x4; 
    static liczba Y , Ys, e; 

    e = Yp - Y;

    x1p = x2 +l1*e;
    x2p = x3 + l2*e;
    x3p = x4 + l3*e;
    x4p = -1*a*x2 -b*x3 -c*x4 +syg + l4*e;

    x1+=x1p*h;
    x2+= x2p*h;
    x3+= x3p*h;
    x4+= x4p*h;

    Y = wa*x1 - wb*x2 + wc*x3;
    
    return Y;
}



liczba modelStanowy(liczba syg){

    static const liczba a = 1.65*pow(10,9), b =4.85*pow(10,6), c=3012; 
    static const liczba wa =1.64*pow(10,11), wb = 2.52*pow(10,5), wc = 0.153;


    static liczba x1p, x2p, x3p, x4p;
    static liczba x1, x2, x3, x4; 
    static liczba Y;

    x1p = x2;
    x2p = x3;
    x3p = x4;
    x4p = -1*a*x2 -b*x3 -c*x4 +syg;

    x1+=x1p*h;
    x2+= x2p*h;
    x3+= x3p*h;
    x4+= x4p*h;

    Y = wa*x1 - wb*x2 + wc*x3;
    return Y*2;
}


liczba modelStanowyObs(liczba syg){

    static const liczba a = 1.65*pow(10,9), b =4.85*pow(10,6), c=3012; 
    static const liczba wa =1.64*pow(10,11), wb = 2.52*pow(10,5), wc = 0.153;


    static liczba x1p, x2p, x3p, x4p;
    static liczba x1, x2, x3, x4; 
    static liczba Y;

    x1p = -c*x1 + x2;
    x2p = -b*x1 + x3 + wc*syg;
    x3p = -a*x1 + x4 +wb*syg;
    x4p = wa*syg;

    x1+=x1p*h;
    x2+= x2p*h;
    x3+= x3p*h;
    x4+= x4p*h;

    Y = x1;
    return Y;
}


liczba P(liczba syg, liczba P =0.03){
    return syg*P ;
}


liczba PID(liczba syg){

    const liczba Kp2 = 0.6*5.3 *1.15;
    const liczba Ti2 = 0.5 * 0.01567 *1.7;
    const liczba Td2 = 0.125*0.01567 *1.2; 
    const liczba Ta =1.1;

    static liczba  Y, Us;
    static liczba calk;

    const liczba  Kp =5.24;
    const liczba Ti = 0.00579 ;
    const liczba Td = 0.001448;

    Y = Kp2*(syg +Td2*(syg-Us)/h + calk/Ti2);

    liczba Ysat = nasycenie(Y);

    calk += (((Ysat-Y)/Ta) +syg)*h; //
    Us = syg;

    return Y;
}


liczba PI(liczba syg){

    static liczba  Y, calk;
    const liczba Kp = 3.93, Ti = 0.00869;

    Y = Kp*syg + nasycenie(calk*(Kp/Ti), 5/Kp, -5/Kp);
    calk += syg*h;
    return Y;

}


liczba LEAD(liczba syg){
   
    const liczba zero = 282;
    const liczba biegun = 1032;
    const liczba wzm = 7.346;

    static liczba Y1,Y, Us,Y1s, Ys;
    Y1 = (syg -Us)/h + zero*syg - Ys*biegun;
    Y+= Y1s*h;

    Y1s = Y1;
    Ys = Y;
    Us = syg;

    return Y*wzm;

}


liczba LAG(liczba syg){
   
    const liczba zero = 5.64;
    const liczba biegun = 0.58;
    const liczba wzm = 1;

    static liczba Y1,Y, Us,Y1s, Ys;
    Y1 = (syg -Us)/h + zero*syg - Ys*biegun;
    Y+= Y1s*h;

    Y1s = Y1;
    Ys = Y;
    Us = syg;

    return Y*wzm;

}


liczba nasycenie(liczba syg, liczba gora , liczba dol ){
    return  (syg < gora && syg >dol ?  syg : (syg >= gora? gora : dol ));
}


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

    plik<<"Y,e,czas,R"<<std::endl;
    plik <<h <<',' <<czasKoniec <<','<<Tp<<','<<0<<std::endl;
    plik <<Ti <<',' <<Kp <<','<<a1<<','<<0<<std::endl;
    plik <<a2 <<',' <<To <<','<<0<<','<<0<<std::endl;

    for(int i=0; i<dlugSym;i++)
        plik<<tab.Y[i] <<',' <<tab.e[i] <<',' << tab.czas[i] <<','<<tab.R[i]<<std::endl;
    plik.close();

    return 0;
}


void obliczenia(tabs& tab){

    for (int i=0; i<dlugSym -1-opoz*5; i++) {
        
        tab.e[i] = tab.R[i] -tab.Yczuj[i] ;  
        tab.U[i] = P(tab.e[i]);

        // tab.U[i] = LEAD(tab.U[i]);
        // tab.U[i] = LAG(tab.U[i]);
        // tab.U[i] = PID(tab.U[i]);

        tab.Uster[i] = nasycenie(tab.U[i]);  
        tab.Y[i+1 +opoz*5] = obiekt(tab.Uster[i]);
        tab.Yczuj[i+1 +opoz] = czujnik(tab.Y[i]);
                
         }
    return;
}



std::tuple<liczba,liczba> Bode(liczba* Y,liczba* R,liczba freq){



    std::cout <<freq <<' ';

    liczba maxY =-1;

    for(int i=dlugSym-1; i>(dlugSym-1)*0.8;i--)
        if(Y[i]>=maxY)
            maxY = Y[i];        
    

    //liczba faza = (maxYidx - maxRidx)*h*freq /360;
    liczba faza = 180 *atan2(Y[int(dlugSym*0.8)], R[int(dlugSym-1*0.8)])/M_PI;
    liczba wzm = maxY;

    return  std::tuple <liczba,liczba> {faza,wzm};

}

int main(){

    tabs tab;  
    std::ofstream plik("Wyjscie_symulacji.csv");

    if(BODE){

    std::ofstream plikBode("Bode_sym.csv");
    int dlug = 60; // ???vdokjvcsnjbnijb

    liczba faza[dlug] = {0};
    liczba wzm[dlug] = {0};
    liczba freqs[dlug] = {0};

    liczba tmpFaza =0, tmpWzm =0;

    for(long int i=0; i<6;i++)
        for(long int j=0; j<10;j++){
            freqs[10*i +j ] = (j +1) *pow(10,i);
            std::cout << freqs[10*i + j] <<' ';
        }
        
    std::cout<< "Wzm :    " <<"faza"<<std::endl;    
    for(int i=0; i<dlug; i++){

        inicjalizujTablice(tab,freqs[i]);
    
        obliczenia(tab);

        std::tie (tmpFaza, tmpWzm) = Bode(tab.Y, tab.R,freqs[i]);

        wzm[i] = tmpWzm;

        std::cout<<  tmpWzm<<"   " <<tmpFaza << std::endl;
        faza[i] = tmpFaza;

    }

    for(int i=0; i<60;i++)
        plikBode<<wzm[i] <<',' <<faza[i] <<',' << freqs[i]<<std::endl;
    plikBode.close();
    return 0;
    }

    inicjalizujTablice(tab,'s');

    obliczenia(tab);

    zapiszPlik(tab,plik);

    czyscTablice(tab);
    
    return 0;
}