function Mastermind
%this is the game where the machine proposes a hidden code and the user
%tries to guess it.
clc; clear all;
fprintf('Welcome to mastermind!\n This is a game where you have to guess a hidden combination\n of four colours, between these: red, yellow, green, blue, orange and purple.\n If you guess a colour, you will have a white ball, and if you guess a colour\n and its position, you will have a black ball. You win if you have 4 black\n balls before 7 attempts.\n');
colorsavailable=char('red','yellow','green','blue','orange','purple');
hiddencode=char(colorsavailable(ceil(6*rand(1)),:),colorsavailable(ceil(6*rand(1)),:),colorsavailable(ceil(6*rand(1)),:),colorsavailable(ceil(6*rand(1)),:));
%I have generated a random hidden code, so it doesn't have to be predefined
%and always the same

found=false;
black=0;
white=0;
counter=0; %to count how many attempts. At 7, you loose.
while found==false
    j1=input('Write a combination of four colours: ','s'); %the user has to put four colours separated by spaces
    black=numberofblacks(j1); %these are two functions that written below
    white=numberofwhites(j1);
    fprintf('The number of blacks is: %g\n',black);
    fprintf('The number of whites is: %g\n',white);
    
    if black==4
        found=true;
        fprintf('You have won!\n');
    end
    
    black=0; 
    white=0;
    counter=counter+1;
    if counter==7 && black<4
        fprintf('You loose... You have already had 7 attempts.\n The code was: %s %s %s %s\n',hiddencode(1,:),hiddencode(2,:),hiddencode(3,:),hiddencode(4,:));
        break;
    end
end


function black=numberofblacks(j1)
black=0;
space=strfind(j1,' ');
if j1(1,1)==hiddencode(1,1) %as all the colours begin with a different letter, I just have to compare the first letter and I won't have problems with agreement of matrix dimensions
    black=black+1;
end
if j1(1,space(1)+1)==hiddencode(2,1) %here we check if the second word coincides
    black=black+1;
end
if j1(1,space(2)+1)==hiddencode(3,1) %here he third
    black=black+1;
end
if j1(1,space(3)+1)==hiddencode(4,1)
    black=black+1;
end
black;
end

function white=numberofwhites(j1)
white=0;
sred=strfind(j1,'red');
syellow=strfind(j1,'yellow');
sgreen=strfind(j1,'green');
sblue=strfind(j1,'blue');
sorange=strfind(j1,'orange');
spurple=strfind(j1,'purple');

spc=' ';
%to use strfind the string has to be a row, so...
hiddencoderow=[hiddencode(1,:) spc hiddencode(2,:) spc hiddencode(3,:) spc hiddencode(4,:)]; %I put spc because if I have yellow orange or purple, they are the words with more letters so there will be no spaces between them

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