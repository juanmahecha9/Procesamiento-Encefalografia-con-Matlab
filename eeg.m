clc;

close all;

%% SIGNAL LOADING...

x=xlsread('senal.xlsx');

%% TOMA DE LOS VECTORES DE EXCEL

canal1=detrend (x(:,1)); %Canal 1

canal2=detrend(x(:,2)); % Canal 2

%% DIFERENCIA DE LOS CANALES

diferencia=canal1-canal2;

L= length(canal1);

t=(0:L-1)*1/250;

%% PLOT SE�AL

figure(1)

subplot(3, 1, 1)

%Canal 1

plot(t, canal1)

xlabel('Tiempo')

ylabel('Amplitud')

title ('Canal N�1')

subplot(3, 1, 2)

%Canal 2

plot(t, canal2)

xlabel('Tiempo')

ylabel('Amplitud')

title ('Canal N�2')

subplot(3, 1, 3)

%Diferencia

plot(t, diferencia)

xlabel('Tiempo')

ylabel('Amplitud')

title ('Diferencia')

 

%--------------------------------%



%Densidad espectral de la se�al %

 

%Frecuencia de muestreo

fs=250;

 

% Power Welch -> estimado de densidad espectral

 

[pxx,f]=pwelch(canal1,[],[],[],fs);

                

figure(2)

subplot(3, 1, 1)

%Canal 1

plot(f, pxx)

xlabel('Samples')

ylabel('Signal Amplitude')

title ('Densidad espectral de Canal N�1')

 

[pxx1,f]=pwelch(canal2,[],[],[],fs;

subplot(3, 1, 2)           

%Canal 2

plot(f, pxx1)

xlabel('Samples')

ylabel('Signal Amplitude')

title ('Densidad espectral de Canal N�2')

[pxx2,f]=pwelch(canal1,[],[],[],fs;

                

subplot(3, 1, 3)

%Diferencia

plot(f, pxx2)

xlabel('Samples')

ylabel('Signal Amplitude')

title ('Densidad espectral de diferencia de se�ales')

 

%---------------------------------%

 

%%%%%%%%%%% Espectograma %%%%%%%%%%

figure(3)

subplot(3, 1, 1)

%Canal 1

spectrogram(canal1,200, 100, length(canal1), fs);

title ('Espectograma Canal N�1')

 

subplot(3, 1, 2)

%Canal 2

spectrogram(canal2,200, 100, length(canal2), fs);

title ('Espectograma Canal N�2')

 

subplot(3, 1, 3)

%Diferencia

spectrogram(diferencia,200, 100, length(diferencia), fs);

title ('Espectograma diferencia')

 

%---------------------------------%

 

%%%%%%%%%%% Separaci�n %%%%%%%%%%

ch1=[0 0 0 0];

%%Canal 1%%

Ord=20;

T=1/fs;

L= length(canal1);

t=(0:L-1)*T;

 

%%Onda Delta 0.5 - 4 Hz

 

NFFT = 2^nextpow2(L);

Y = fft(canal1,NFFT)/L;

f = fs/2*linspace(0,1,NFFT/2+1);

figure(4)

subplot(6,2,[1:2])

plot(t,canal1)

title('Canal1')

Y(f<0.5 | f>4)=0;

x=real(ifft(Y,'nonsymmetric'));

x=x(1:L);

for i=1:Ord

NFFT = 2^nextpow2(L);

Y = fft(x,NFFT)/L;

f = fs/2*linspace(0,1,NFFT/2+1);

Y(f<0.5 | f>4)=0;

x=real(ifft(Y,'nonsymmetric'));

x=x(1:L);

end

subplot(5,2,3)

plot(t, x);

title('Onda Delta')

NFFT = 2^nextpow2(L);

Y1 = fft(x,NFFT)/L;

f = fs/2*linspace(0,1,NFFT/2+1);

subplot(5,2,4)

hold on

plot(f, 2*abs(Y1(1:NFFT/2+1)))

axis([0 40 0 3e-72]);

title('Onda Delta en Frecuencia')

ch11 = sum(2*abs(Y1(1:NFFT/2+1)));

 

%%Onda Theta 4 - 8 Hz

 

NFFT = 2^nextpow2(L);

Y3 = fft(canal1,NFFT)/L;

f = fs/2*linspace(0,1,NFFT/2+1);

 

Y3(f<4 | f>8)=0;

x1=real(ifft(Y3,'nonsymmetric'));

x1=x1(1:L);

for i=1:Ord

NFFT = 2^nextpow2(L);

Y3 = fft(x1,NFFT)/L;

f = fs/2*linspace(0,1,NFFT/2+1);

Y3(f<4 | f>8)=0;

x1=real(ifft(Y3,'nonsymmetric'));

x1=x1(1:L);

end

subplot(5,2,5)

plot(t, x1);

title('Onda Theta')

NFFT = 2^nextpow2(L);

Y4 = fft(x1,NFFT)/L;

f = fs/2*linspace(0,1,NFFT/2+1);

subplot(5,2,6)

hold on

plot(f, 2*abs(Y4(1:NFFT/2+1)))

axis([0 40 0 3e-72]);

title('Onda Theta en Frecuencia')

ch12 = sum(2*abs(Y4(1:NFFT/2+1)));

 

%%Onda Alfa 8 - 13 Hz

 

NFFT = 2^nextpow2(L);

Y5 = fft(canal1,NFFT)/L;

f = fs/2*linspace(0,1,NFFT/2+1);

 

Y5(f<8 | f>13)=0;

x2=real(ifft(Y5,'nonsymmetric'));

x2=x2(1:L);

for i=1:Ord

NFFT = 2^nextpow2(L);

Y5 = fft(x2,NFFT)/L;

f = fs/2*linspace(0,1,NFFT/2+1);

Y5(f<8 | f>13)=0;

x2=real(ifft(Y5,'nonsymmetric'));

x2=x2(1:L);

end

subplot(5,2,7)

plot(t, x2);

title('Onda Alfa')

NFFT = 2^nextpow2(L);

Y6 = fft(x2,NFFT)/L;

f = fs/2*linspace(0,1,NFFT/2+1);

subplot(5,2,8)

hold on

plot(f, 2*abs(Y6(1:NFFT/2+1)))

axis([0 40 0 3e-72]);

title('Onda Alfa en Frecuencia')

ch13 = sum(2*abs(Y6(1:NFFT/2+1)));

 

%%Onda Beta 13 - 30 Hz

 

NFFT = 2^nextpow2(L);

Y7 = fft(canal1,NFFT)/L;

f = fs/2*linspace(0,1,NFFT/2+1);

 

Y7(f<13 | f>30)=0;

x3=real(ifft(Y7,'nonsymmetric'));

x3=x3(1:L);

for i=1:Ord

NFFT = 2^nextpow2(L);

Y7 = fft(x3,NFFT)/L;

f = fs/2*linspace(0,1,NFFT/2+1);

Y7(f<13 | f>30)=0;

x3=real(ifft(Y7,'nonsymmetric'));

x3=x3(1:L);

end

subplot(5,2,9)

plot(t, x3);

title('Onda Beta')

NFFT = 2^nextpow2(L);

Y8 = fft(x3,NFFT)/L;

f = fs/2*linspace(0,1,NFFT/2+1);

subplot(5,2,10)

hold on

plot(f, 2*abs(Y8(1:NFFT/2+1)))

axis([0 40 0 3e-72]);

title('Onda Beta en Frecuencia')

ch14 = sum(2*abs(Y8(1:NFFT/2+1)));

 

%%Vector para suma de valores

ch1 = [ch11 ch12 ch13 ch14];

%%Determinaci�n de valor mayor

max1 = max(max(ch1));

 

switch max1

    case ch11

        subplot(5,2,4)

        plot(f, 2*abs(Y1(1:NFFT/2+1)), 'r')

        axis([0 40 0 3e-72]);

        title('Onda Delta en Frecuencia')

        legend(num2str(ch11));

        subplot(5,2,6)

        legend(num2str(ch12));

        subplot(5,2,8)

        legend(num2str(ch13));

        subplot(5,2,10)

        legend(num2str(ch14));

    case ch12

        subplot(5,2,6)

        plot(f, 2*abs(Y3(1:NFFT/2+1)), 'r')

        axis([0 40 0 3e-72]);

        title('Onda Tetha en Frecuencia')

        legend(num2str(ch12));

        subplot(5,2,4)

        legend(num2str(ch11));

        subplot(5,2,8)

        legend(num2str(ch13));

        subplot(5,2,10)

        legend(num2str(ch14));

    case ch13

        subplot(5,2,8)

        plot(f, 2*abs(Y6(1:NFFT/2+1)), 'r')

        axis([0 40 0 3e-72]);

        title('Onda Alfa en Frecuencia')

        legend(num2str(ch13));

        subplot(5,2,6)

        legend(num2str(ch12));

        subplot(5,2,4)

        legend(num2str(ch11));

        subplot(5,2,10)

        legend(num2str(ch14));

    case ch14

        subplot(5,2,10)

        plot(f, 2*abs(Y8(1:NFFT/2+1)), 'r')

        axis([0 40 0 3e-72]);

        title('Onda Beta en Frecuencia')

        legend(num2str(ch14));

        subplot(5,2,6)

        legend(num2str(ch12));

        subplot(5,2,8)

        legend(num2str(ch13));

        subplot(5,2,4)

        legend(num2str(ch11)); 

end

 

%Canal 2%

 

L= length(canal2);

 

%%Onda Delta 0.5 - 4 Hz

 

NFFT = 2^nextpow2(L);

P = fft(canal2,NFFT)/L;

f = fs/2*linspace(0,1,NFFT/2+1);

figure(5)

subplot(5,2,[1:2])

plot(t,canal2)

title('Canal2')

P(f<0.5 | f>4)=0;

c=real(ifft(P,'nonsymmetric'));

c=c(1:L);

for i=1:Ord

NFFT = 2^nextpow2(L);

P = fft(c,NFFT)/L;

f = fs/2*linspace(0,1,NFFT/2+1);

P(f<0.5 | f>4)=0;

c=real(ifft(P,'nonsymmetric'));

c=c(1:L);

end

subplot(5,2,3)

plot(t, c);

title('Onda Delta')

NFFT = 2^nextpow2(L);

P1 = fft(c,NFFT)/L;

f = fs/2*linspace(0,1,NFFT/2+1);

subplot(5,2,4)

plot(f, 2*abs(P1(1:NFFT/2+1)))

axis([0 40 0 3e-72]);

title('Onda Delta en Frecuencia')

 ch21 = sum(2*abs(P1(1:NFFT/2+1)));

 

%%Onda Theta 4 - 8 Hz

 

NFFT = 2^nextpow2(L);

P3 = fft(canal2,NFFT)/L;

f = fs/2*linspace(0,1,NFFT/2+1);

 

P3(f<4 | f>8)=0;

c1=real(ifft(P3,'nonsymmetric'));

c1=c1(1:L);

for i=1:Ord

NFFT = 2^nextpow2(L);

P3 = fft(c1,NFFT)/L;

f = fs/2*linspace(0,1,NFFT/2+1);

P3(f<4 | f>8)=0;

c1=real(ifft(P3,'nonsymmetric'));

c1=c1(1:L);

end

subplot(5,2,5)

plot(t, c1);

title('Onda Theta')

NFFT = 2^nextpow2(L);

P4 = fft(c1,NFFT)/L;

f = fs/2*linspace(0,1,NFFT/2+1);

subplot(5,2,6)

plot(f, 2*abs(P4(1:NFFT/2+1)))

axis([0 40 0 3e-72]);

title('Onda Theta en Frecuencia')

 ch22 = sum(2*abs(P4(1:NFFT/2+1)));

 

%%Onda Alfa 8 - 13 Hz

 

NFFT = 2^nextpow2(L);

P5 = fft(canal2,NFFT)/L;

f = fs/2*linspace(0,1,NFFT/2+1);

 

P5(f<8 | f>13)=0;

c2=real(ifft(P5,'nonsymmetric'));

c2=c2(1:L);

for i=1:Ord

NFFT = 2^nextpow2(L);

P5 = fft(c2,NFFT)/L;

f = fs/2*linspace(0,1,NFFT/2+1);

P5(f<8 | f>13)=0;

c2=real(ifft(P5,'nonsymmetric'));

c2=c2(1:L);

end

subplot(5,2,7)

plot(t, c2);

title('Onda Alfa')

NFFT = 2^nextpow2(L); P6 = fft(c2,NFFT)/L;

f = fs/2*linspace(0,1,NFFT/2+1);

subplot(5,2,8)

plot(f, 2*abs(P6(1:NFFT/2+1)))

axis([0 40 0 3e-72]);

title('Onda Alfa en Frecuencia')

 ch23 = sum(2*abs(P6(1:NFFT/2+1)));

 

%%Onda Beta 13 - 30 Hz

 

NFFT = 2^nextpow2(L);

P7 = fft(canal2,NFFT)/L;

f = fs/2*linspace(0,1,NFFT/2+1);

 

P7(f<13 | f>30)=0;

c3=real(ifft(P7,'nonsymmetric'));

c3=c3(1:L);

for i=1:Ord

NFFT = 2^nextpow2(L);

P7 = fft(c3,NFFT)/L;

f = fs/2*linspace(0,1,NFFT/2+1);

P7(f<13 | f>30)=0;

c3=real(ifft(P7,'nonsymmetric'));

c3=c3(1:L);

end

subplot(5,2,9)

plot(t, c3);

title('Onda Beta')

NFFT = 2^nextpow2(L);

P8 = fft(c3,NFFT)/L;

f = fs/2*linspace(0,1,NFFT/2+1);

subplot(5,2,10)

plot(f, 2*abs(P8(1:NFFT/2+1)))

axis([0 40 0 3e-72]);

title('Onda Beta en Frecuencia')

ch24 = sum(2*abs(P8(1:NFFT/2+1)));

 

%%Vector para suma de valores

ch2 = [ch21 ch22 ch23 ch24];

%%Determinaci�n de valor mayor

max2 = max(max(ch2));

 

switch max2

    case ch21

        subplot(5,2,4)

        plot(f, 2*abs(P1(1:NFFT/2+1)), 'r')

        axis([0 40 0 3e-72]);

        title('Onda Delta en Frecuencia')

        legend(num2str(ch21));

        subplot(5,2,6)

        legend(num2str(ch22));

        subplot(5,2,8)

        legend(num2str(ch23));

        subplot(5,2,10)

        legend(num2str(ch24));

    case ch22

        subplot(5,2,6)

        plot(f, 2*abs(P3(1:NFFT/2+1)), 'r')

        axis([0 40 0 3e-72]);

        title('Onda Tetha en Frecuencia')

        legend(num2str(ch22));

        subplot(5,2,4)

        legend(num2str(ch21));

        subplot(5,2,8)

        legend(num2str(ch23));

        subplot(5,2,10)

        legend(num2str(ch24));

    case ch23

        subplot(5,2,8)

        plot(f, 2*abs(P6(1:NFFT/2+1)), 'r')

        axis([0 40 0 3e-72]);

        title('Onda Alfa en Frecuencia')

        legend(num2str(ch23));

        subplot(5,2,6)

        legend(num2str(ch22));

        subplot(5,2,4)

        legend(num2str(ch21));

        subplot(5,2,10)

        legend(num2str(ch24));

    case ch24

        subplot(5,2,10)

        plot(f, 2*abs(P8(1:NFFT/2+1)), 'r')

        axis([0 40 0 3e-72]);

        title('Onda Beta en Frecuencia')

        legend(num2str(ch24));

        subplot(5,2,6)

        legend(num2str(ch22));

        subplot(5,2,8)

        legend(num2str(ch23));

        subplot(5,2,4)

        legend(num2str(ch21)); 

end