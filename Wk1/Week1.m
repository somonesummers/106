% Week 1 problems

%% Problem 7 Use histogram() function and learn to roll dice
% n = 100;
% sum7 = unidrnd(6,1,n) + unidrnd(6,1,n);
n = 10000;
figure
histogram(sum(unidrnd(6,2,n),1)) %Roll 2 dice n times, sum the pairs of dice

%% Problem 8 Compare odds of 2 scenarios of die(dice) rolling
n = 1000000;
odds1 = zeros(1,n);
odds2 = zeros(1,n);
for i = 1:n
sum8 = sum(unidrnd(6,2,24),1); %roll 2 dice, 24 times
odds1(i) = max(sum8 == 12); %at least 1x 12

die = unidrnd(6,1,4); %roll 1 die, 4 times
odds2(i) = max(die == 6); %at least 1x 6
end
trueOdds1 = 1-(35/36)^24;
trueOdds2 = 1-(5/6)^4;
disp("Odds of at least 1x 12 in 24 tosses is : " + mean(odds1) + " (" + trueOdds1 + ")")
disp("Odds of at least 1x  6 in  4 tosses is : " + mean(odds2) + " (" + trueOdds2 + ")")

%% Problem 9 Simulate n number of craps games, compare to theoretical odds
n = 1000000;
outcome = zeros(1,n);
tic
for i = 1:n % this is a non-optimized loop, but thats OK
    ss = 0;
%     sum9 = unidrnd(6,1,1) + unidrnd(6,1,1); %roll 2 dice, 1 time
    sum9 = sum(unidrnd(6,2,1),1); %roll 2 dice, 1 time
    if (sum9 == 3 || sum9 == 2 || sum9 == 12)
        outcome(i) = 0; % lose
%          disp(sum9 + " Lose")
    elseif (sum9 == 7 || sum9 == 11)
        outcome(i) = 1; % win
%         disp(sum9 + " Win")
    elseif (sum9 == 8 || sum9 == 6 || sum9 == 9 || sum9 == 5 || sum9 == 10 || sum9 == 4)
        while( ss ~= sum9 && ss ~= 7)
            ss = sum(unidrnd(6,2,1),1); %roll 2 dice, 1 time
%             disp(sum9 + " " + ss)
        end
        if(ss == sum9)
            outcome(i) = 1; % win
            ss = 0; %reset subroll
%             disp(sum9 + " " + ss + " Win")
        elseif(ss == 7)
            outcome(i) = 0; % lose
%             disp(sum9 + " " + ss + " Lose")
            ss = 0; %reset subroll
        else
            outcome(i) = nan; % error
            warning('bad follow up roll')
            ss = 0; %reset subroll
        end
    else
        outcome(i) = nan; % error
        warning('bad initial toss')
    end
end

trueOdds = 8/36 + 2*3/36*3/9 + 2*4/36*4/10 + 2*5/36*5/11;  
disp(mean(outcome) + "(" + trueOdds + ")")
toc

