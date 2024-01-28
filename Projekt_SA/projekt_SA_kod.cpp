#include <iostream>
#include <fstream>
#include <cmath>
#include <tuple>


typedef double liczba;


const bool BODE = false;
const  liczba h = 0.000001;
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

};


void inicjalizujTablice(tabs& tab,liczba freq =1);

liczba obiekt(liczba syg);

int zapiszPlik(tabs tab, std::ofstream & plik);

liczba nasycenie(liczba syg, liczba gora =5 , liczba dol =-5 );


void inicjalizujTablice(tabs& tab,liczba freq){
    for(int i=0; i<dlugSym; i++){
        
        tab.czas[i] = h*i;
        tab.R[i] = 1;
        if(BODE)
             tab.R[i] =sin(h*i*2*M_PI*freq);
        //tab.R[i] = h*i;
        
        // int prog = 10000;

        // if(i<prog || (i> 2*prog && i< 3*prog )|| (i>4*prog && i< 5*prog))
        //     tab.R[i] = 1;
        // }  
    }
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
       // tab.U[i] = PID(tab.U[i]);
        tab.Uster[i] = nasycenie(tab.U[i]);     
        tab.Y[i+1 +opoz*5] = obiekt(tab.Uster[i]);
        tab.Yczuj[i+1 +opoz] = czujnik(tab.Y[i]);
                
         }
    return;
}



std::tuple<liczba,liczba> Bode(liczba* Y,liczba* R,liczba freq){



    std::cout <<freq;

    liczba maxY =-1,maxR =-1;
    int maxYidx =0,maxRidx =0;


    for(int i=dlugSym-1; i>(dlugSym-1)*0.4;i--){


        if(Y[i]>maxY){
            maxY = Y[i];
            maxYidx = i;
        }
        if (R[i]>maxR){
            maxR = R[i];
            maxRidx =i;
        }        

    }

    liczba faza = (maxYidx - maxRidx)*h*freq /360;
    liczba wzm = maxY/maxR;

    return  std::tuple <liczba,liczba> {faza,wzm};

}

int main(){


    tabs tab;  
    std::ofstream plik("Wyjscie_symulacji.csv");
    std::ofstream plikBode("Bode_sym.csv");

    if(BODE){

    int dlug = 59; // ???vdokjvcsnjbnijb

    liczba faza[dlug] = {0};
    liczba wzm[dlug] = {0};
    liczba freqs[dlug] = {0};

    liczba tmpFaza =0, tmpWzm =0;

    for(long int i=0; i<6;i++)
        for(long int j=1; j<10;j++){
            freqs[10*i +j -1 ] = (j) *pow(10,i);
            std::cout << freqs[10*i + j -1] <<' ';
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

    inicjalizujTablice(tab);

    // for(int i=0; i< dlugSym-1; i++)
    //     tab.Y[i+1] = PID(tab.R[i]);
    
    obliczenia(tab);
    
    zapiszPlik(tab,plik);

    czyscTablice(tab);




    // for (int i=-10; i<10;i++)
    //     std::cout <<nasycenie(i)<<"  ";
    
    return 0;
}