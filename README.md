# Black-Scholes-Formula
Option Pricing Using the Black Scholes Formula

### Options
Options are derivative securities, representing a right (not obligation) to buy or sell the underlying security at a given price on or before a specified period of time.

### Black Scholes Formula
C(0) = S(0)N(d1) – Ke(-rT)N(d2)\
<br>
Where, d1 = ln(S(0)/K) + (r + σ<sup>2</sup>/2)T and d2 = d1 - σ√T\
<br>
C(0): call option price\
S(0): current price of the underlying asset or spot price.\
N(d): cumulative probability distribution function\
![image](https://user-images.githubusercontent.com/58243776/163833400-a4036411-b827-43ac-9d13-be165611a88c.png)

r: annualized risk-free interest rate\
σ: volatility\
T: maturity time or expiry time.\
K: strike price or exercise price.
