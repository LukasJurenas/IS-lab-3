clc
clear all
close all
x = 0.1: 1/22 : 1;
y = ((1 + 0.6*sin(2*pi*x/0.7)) + 0.3*sin(2*pi*x))/2;
figure(1)
plot(x,y)
grid("on")

%aprasomi svoriai
w1 = randn(1);
w2 = randn(1);
b = randn(1);

%Pasirenkam Gauso f-jos parametrus pagal pradines f-jos grafika
c1 = 0.2;
c2 = 0.9;
r1 = 0.15;
r2 = 0.15;

%parenkame mokymo zingsni
eta = 0.1;
Y = zeros(1,length(x)); %cia laikysime nuspejamu tasku reiksmes

% Mokymas
for j = 1:10000
    %Mokyma atliekam kiekvienam duomenu taskui
    for n = 1:length(x)
        %Pasleptasis sluoksnis pakeistas dviem Gauso aktyvavimo f-jom
        F1 = exp(-((x(n)-c1)^2)/(2*(r1^2)));
        F2 = exp(-((x(n)-c2)^2)/(2*(r2^2)));
        % Final tinklo tiesine aktyvavimo f-ja
        Y(n) = F1*w1+F2*w2+b;
        % Apskaičiuojama klaida
        e = y(n) - Y(n);
        % Atnaujinami svoriai
        w1 = w1+eta*e*F1;
        w2 = w2+eta*e*F2;
        b = b+eta*e;
    end
end
 % hold on
 % plot(x,Y)
 % hold off
 % legend('Target','Predicted')


%testavimas
x1 = 0.1: 1/100 : 1;
Y_test = zeros(1, length(x1));

for i = 1:length(x1)
   F1_test = exp(-((x1(i)-c1)^2)/(2*(r1^2)));
   F2_test = exp(-((x1(i)-c2)^2)/(2*(r2^2)));
   Y_test(i) = F1_test*w1+F2_test*w2+b;
end

hold on
plot(x1,Y_test, 'r-')
hold off
xlabel('Input (x1)');
ylabel('Output (Y)');
legend('Target','Predicted')