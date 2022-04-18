Copyright (c) 2022 Narayan Jee Jha
All rights reserved.

This source code is licensed under the MIT license found in the
LICENSE file in the root directory of this source tree

% European Option Pricing Using the Black Scholes Formula.

clear    % Clear MATLAB Workspace.
clc      % Clear MATLAB Command Window.

% Title of the program.
fprintf("<strong>\t\tA PROGRAM TO CALCULATE THE EUROPEAN OPTION " + ...
    "PRICE \n\t\t\tUSING THE BLACK SCHOLES FORMULA</strong>\n\n");

% Symbolioc variables.
syms S % Current stock price.
syms K % Strike price.
syms c % Volatility of the asset.
syms r % Risk-free interest rate.
syms T % Maturity time.

% Inputs
fprintf("<strong>Please provide the following inputs.</strong>");
S = input("\n\nEnter the current stock price:");
K = input("Enter the strike price:");
c = input("Enter the volatility of the asset:");
r = input("Enter the risk-free interest rate:");
T = input("Enter the maturity time (in years):");

% If there's any dividend?
y_n = input("\nEnter '1' if there's any dividend else enter '0'.");

if y_n == 1
    iscontinuous = input("\nEnter '1' if the paid dividend is " + ...
        "continuous else enter '0'.");
    if iscontinuous == 1
        rdivcont = input("\nEnter the continuous dividend rate.");
        % Adjusted stock price in case of continuous dividend.
        S = S*exp(-rdivcont*T);
    else
        n = input("\nEnter the number of dividends paid.");
        amtdiv = zeros(1,n);
        tdiv = zeros(1,n);
        for i = 1:n
            amtdiv(i) = input(['Enter the amount of ' num2str(i) ...
                'th dividend.']);
            tdiv(i) = input(['Enter the payment time (in years) of ' num2str(i) ...
                'th dividend.']);
        end
        % Adjusted stock price in case of discontinuous dividend.
        for i = 1:n
            S = S - amtdiv(i)*exp(-r*tdiv(i));
        end
    end
end

% Calculations
d1 = (log(S/K) + (r + c*c/2)*T)/(c*sqrt(T));
d2 = d1 - c*sqrt(T);

% User's choice.
call_or_put = input("\nEnter '1' for the calcultion of the call " + ...
    "option price else \n'0' for the calculation of the put option price.");

if call_or_put == 1
    call_option_price = calloption(S, d1, d2, K, r, T);
    fprintf("<strong>\nCall option price = %f</strong>", call_option_price);
    calloptionplot(K, c, r);
else
    put_option_price = putoption(S, d1, d2, K, r, T);
    fprintf("<strong>\nPut option price = %f</strong>", put_option_price);
    putoptionplot(K, c, r);
end

% Call option calculation.
function callprice = calloption(S, d1, d2, K, r, T)
    phyd1 = normcdf(d1);
    phyd2 = normcdf(d2);
    callprice = (S*phyd1) - (K*exp(-r*T)*phyd2);
end

% Put option calculation.
function putprice = putoption(S, d1, d2, K, r, T)
    phyd1 = normcdf(-d1);
    phyd2 = normcdf(-d2);
    putprice = (K*exp(-r*T)*phyd2) - (S*phyd1);
end

% European Call Option Price Plot.
function calloptionplot(K, c, r)
    fprintf("<strong>\n\nCALL OPTION PRICE PLOT</strong>");
    syms t s
    d1 = (log(s/K) + (r + c*c/2)*t)/(c*sqrt(t));
    d2 = d1 - c*sqrt(t);
    phy_d1 = int(exp(-((t)^2)/2),-Inf,d1)*1/sqrt(2*pi);
    phy_d2 = int(exp(-((t)^2)/2),-Inf,d2)*1/sqrt(2*pi);
    C = phy_d1*s - phy_d2*K*exp(-r*t);
     
    sinitial = input("Enter initial stock price: ");
    sfinal = input("Enter final stock price: ");
    tinitial = input("Enter initial time: ");
    tfinal = input("Enter final time: ");
     
    fsurf(C,[sinitial sfinal tinitial tfinal]);
    xlabel('SPOT PRICE');
    ylabel('EXPIRY TIME');
    zlabel('CALL OPTION PRICE');
end

% European Put Option Price Plot.
function putoptionplot(K, c, r)
    fprintf("<strong>\n\nPUT OPTION PRICE PLOT</strong>");
    syms t s
    d1 = (log(s/K) + (r + c*c/2)*t)/(c*sqrt(t));
    d2 = d1 - c*sqrt(t);
    phy_d1 = int(exp(-((t)^2)/2),-Inf,-d1)*1/sqrt(2*pi);
    phy_d2 = int(exp(-((t)^2)/2),-Inf,-d2)*1/sqrt(2*pi);
    C = phy_d2*K*exp(-r*t) - phy_d1*s;
     
    sinitial = input("Enter initial stock price: ");
    sfinal = input("Enter final stock price: ");
    tinitial = input("Enter initial time: ");
    tfinal = input("Enter final time: ");
     
    fsurf(C,[sinitial sfinal tinitial tfinal]);
    xlabel('SPOT PRICE');
    ylabel('EXPIRY TIME');
    zlabel('PUT OPTION PRICE');
end
