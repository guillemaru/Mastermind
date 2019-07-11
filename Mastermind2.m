function Mastermind2
%this is the version in which you propose a code of colours and the
%machine tries to guess it

%Voy a tratar de optimizar a la maquina de dos maneras distintas. La
%primera sería haciendo que cada intento que muestre, lo guarde en una
%matriz, y cada intento que haga, ver si está ya en esa matriz, y si está,
%no mostrarlo. Así reducimos los intentos que va a hacer como mínimo a las
%variaciones de 6 elementos cogidos de 4 en 4, es decir, 6^4=1296. Después
%de eso intentaré reducir un poco más ese número de intentos, calculando el
%numero de negros y blancos que tendría en cada intento, y por ejemplo, si
%su suma es 3, solo cambio una posicion, si es dos, cambio dos
%posiciones... Evidentemente, no es tan lista como un humano, pero desde
%luego es mas eficiente que si simplemente pusiera una combinacion
%aleatoria y comprobara si coincide con el codigo que he introducido. Lo he
%probado muchas veces y necesita una media de 65 intentos, numero mucho
%menor que 1296

clc; clear all;

combinations=[];

save('combinat','combinations');

fprintf('You are going to propone a hidden combination of four colours\n');

%the if that is here together with the input I have put it because I
%had and error. If I put as input four colours that do not arrive till 6
%letters (for example "red red green blue") even when the machine proves
%that code, when I used strcmp, the answer was not 1 because the machine
%was proving a char that every row had 6 characters("red   " "red   "
%"green " "blue ") so the answer was 0 and the machine kept proving other
%codes. So what I did to solve that was that if none of the four colours had 
%6 characters, at least one should have blanks until 6 characters

c11=input('First colour: ','s');
bl=6-length(c11);
if length(c11)<6
    c11=[c11 blanks(bl)];
end

c12=input('Second colour: ','s');
bl2=6-length(c12);


c13=input('Third colour: ','s');
bl3=6-length(c13);


c14=input('Forth colour: ','s');
bl4=6-length(c14);


c1=char(c11,c12,c13,c14);


found=false;
colorsavailable=char('red','yellow','green','blue','orange','purple');


while found==false
    counter=0;
    machinecode=char(colorsavailable(ceil(6*rand(1)),:),colorsavailable(ceil(6*rand(1)),:),colorsavailable(ceil(6*rand(1)),:),colorsavailable(ceil(6*rand(1)),:))
    
    for i=1:1600 %is more or less the number of loops that needs to reproduce the 1296 different possibilities
        
        load('combinat');
        
        spc=' ';
        machinecode2=[machinecode(1,:) spc machinecode(2,:) spc machinecode(3,:) spc machinecode(4,:)];
        
        if i==1
           combinations=[combinations; machinecode2];
           save('combinat','combinations');
           counter=counter+1;
           if strcmp(c1,machinecode)==0
                fprintf('This is not the right code, machine. Try another one\n');
           else 
            found=true;
            fprintf('The machine has guessed the code!\n');
            break;
           end
        end
        if i>1
            s=size(combinations);
            for j=1:s(1) %now, from the matrix combinations, the machine is going to check all its rows to see if any is equal to the code it has just proposed
                if length(machinecode2)==length(combinations(j,:)) %esto lo pongo porque si tienen diferentes dimensiones, el strcmp me da error, y si tienen diferentes dimensiones ya se que no coinciden
                    f=strcmp(machinecode2,combinations(j,:));
                    if f
                        found2=true; %si coincide con otro que ya ha propuesto, que no lo muestre en el command window
                        break;
                    else
                        found2=false;
                    end
                else
                    found2=false;
                end
            end 
            %if after all the iterations...
            if ~found2
                machinecode %the machine shows its attempt to guess the combination
                combinations=[combinations; machinecode2];
                save('combinat','combinations');
                counter=counter+1
                if strcmp(c1,machinecode)==0
                fprintf('This is not the right code, machine. Try another one\n');
                end
            end
        end

        %now that the machine has proposed a new code that has 
        %not been proposed yet, if it's not the
        %right one, let's make another code that is the most similar
        %possible to the right code
        
        if strcmp(c1,machinecode)==1
            found=true;
            fprintf('The machine has guessed the code!\n');
            break;
        else
            black=numberofblacks(machinecode);
            white=numberofwhites(machinecode);
            chco=4-(white+black);
            
            if chco==0 %this is the most important, what makes that the machine guesses the code in less attempts
                %if I have the 4 colours right, don't find new colours,
                %just change the positions of the current colours
                r=ceil(4*rand(1));
                r2=ceil(4*rand(1));
                res=machinecode(r2,:);
                machinecode(r2,:)=machinecode(r,:);
                machinecode(r,:)=res;
            end
            if chco<=4 && chco>0
                rn=ceil(4*rand(1)); %I change a number of colours equal to 4-coloursguessed
                machinecode(rn,:)=colorsavailable(ceil(6*rand(1)),:);
                chco=chco-1;
                if chco>0
                    rn2=ceil(4*rand(1));
                    machinecode(rn2,:)=colorsavailable(ceil(6*rand(1)),:);
                    chco=chco-1;
                    if chco>0
                        rn3=ceil(4*rand(1));
                        machinecode(rn3,:)=colorsavailable(ceil(6*rand(1)),:);
                    end
                end
            end
        end
    end
end




function black=numberofblacks(machinecode)
black=0;
machinecode=[machinecode(1,:) machinecode(2,:) machinecode(3,:) machinecode(4,:)];
%let's try to arrange the string machinecode so it has words followed by
%one space
machinecode=strrep(machinecode,'red   ','red ');
machinecode=strrep(machinecode,'green ','green ');
machinecode=strrep(machinecode,'yellow','yellow ');
machinecode=strrep(machinecode,'blue  ','blue ');
machinecode=strrep(machinecode,'purple','purple ');
machinecode=strrep(machinecode,'orange','orange ');
machinecode=machinecode(1,1:(length(machinecode)-1));

space=strfind(machinecode,' ');
if machinecode(1,1)==c1(1,1) %as all the colours begin with a different letter, I just have to compare the first letter and I won't have problems with agreement of matrix dimensions
    black=black+1;
end
if machinecode(1,space(1)+1)==c1(2,1) %here we check if the second word coincides
    black=black+1;
end
if machinecode(1,space(2)+1)==c1(3,1) %here he third
    black=black+1;
end
if machinecode(1,space(3)+1)==c1(4,1)
    black=black+1;
end
black;
end



function white=numberofwhites(machinecode)
white=0;

spc=' ';
%to use strfind the string has to be a row, so...
machinecode=[machinecode(1,:) spc machinecode(2,:) spc machinecode(3,:) spc machinecode(4,:)];

sred=strfind(machinecode,'red');
syellow=strfind(machinecode,'yellow');
sgreen=strfind(machinecode,'green');
sblue=strfind(machinecode,'blue');
sorange=strfind(machinecode,'orange');
spurple=strfind(machinecode,'purple');

spc=' ';
%to use strfind the string has to be a row, so...
hiddencoderow=[c1(1,:) spc c1(2,:) spc c1(3,:) spc c1(4,:)]; %I put spc because if I have yellow orange or purple, they are the words with more letters so there will be no spaces between them

hred=strfind(hiddencoderow,'red');
hyellow=strfind(hiddencoderow,'yellow');
hgreen=strfind(hiddencoderow,'green');
hblue=strfind(hiddencoderow,'blue');
horange=strfind(hiddencoderow,'orange');
hpurple=strfind(hiddencoderow,'purple');

%now we compare all the cases between the input and the hidden code, in all
%the colours
if length(sred)+2==length(hred)
    white=white+length(sred);
elseif length(sred)==length(hred)+2
    white=white+length(hred);
elseif length(sred)==length(hred)+1
    white=white+length(hred);
elseif length(sred)==length(hred)
    white=white+length(hred);
elseif length(sred)+1==length(hred)
    white=white+length(sred);
end

if length(syellow)+2==length(hyellow)
    white=white+length(syellow);
elseif length(syellow)==length(hyellow)+2
    white=white+length(hyellow);
elseif length(syellow)==length(hyellow)+1
    white=white+length(hyellow);
elseif length(syellow)==length(hyellow)
    white=white+length(hyellow);
elseif length(syellow)+1==length(hyellow)
    white=white+length(syellow);
end

if length(sgreen)+2==length(hgreen)
    white=white+length(sgreen);
elseif length(sgreen)==length(hgreen)+2
    white=white+length(hgreen);
elseif length(sgreen)==length(hgreen)+1
    white=white+length(hgreen);
elseif length(sgreen)==length(hgreen)
    white=white+length(hgreen);
elseif length(sgreen)+1==length(hgreen)
    white=white+length(sgreen);
end

if length(sblue)+2==length(hblue)
    white=white+length(sblue);
elseif length(sblue)==length(hblue)+2
    white=white+length(hblue);
elseif length(sblue)==length(hblue)+1
    white=white+length(hblue);
elseif length(sblue)==length(hblue)
    white=white+length(hblue);
elseif length(sblue)+1==length(hblue)
    white=white+length(sblue);
end

if length(spurple)+2==length(hpurple)
    white=white+length(spurple);
elseif length(spurple)==length(hpurple)+2
    white=white+length(hpurple);
elseif length(spurple)==length(hpurple)+1
    white=white+length(hpurple);
elseif length(spurple)==length(hpurple)
    white=white+length(hpurple);
elseif length(spurple)+1==length(hpurple)
    white=white+length(spurple);
end

if length(sorange)+2==length(horange)
    white=white+length(sorange);
elseif length(sorange)==length(horange)+2
    white=white+length(horange);
elseif length(sorange)==length(horange)+1
    white=white+length(horange);
elseif length(sorange)==length(horange)
    white=white+length(horange);
elseif length(sorange)+1==length(horange)
    white=white+length(sorange);
end

white=white-black;
end


end