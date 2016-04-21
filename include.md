<script>
  (function () {
    var script = document.createElement("script");
    script.type = "text/javascript";
    script.src  = "https://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML";
    document.getElementsByTagName("head")[0].appendChild(script);
  })();
</script>

## Capital Asset Pricing Model

The Capital Asset Pricing Model is a model that describes the relationship between **risk** and **expected return** and that is used in the pricing of risky securities. [investopedia](http://www.investopedia.com/terms/c/capm.asp)

The model takes into account the asset's sensitivity to non-diversifiable risk (also known as systematic risk or market risk), often represented by the quantity **beta** (**$\beta$**)  in the financial industry, as well as the expected return of the market and the expected return of a theoretical risk-free asset. CAPM assumes a particular form of utility functions (in which only first and second moments matter, that is risk is measured by variance, for example a quadratic utility) or alternatively asset returns whose probability distributions are complete described by the first two moments (for example, the normal distribution) and zero transaction costs (necessary for diversification to get rid of all idiosyncratic risk). Under these conditions, CAPM shows that the cost of equity capital is determined only by **beta**. Despite it failing numerous empirical tests and the existence of more modern approaches to asset pricing and portfolio selection (such as arbitrage pricing theory and Merton's portfolio problem), the CAPM still remains popular due to its simplicity and utility in a variety of situations. [wikipedia](https://en.wikipedia.org/wiki/Capital_asset_pricing_model)


## The Model

The formula for the model was introduced by **Jack Traynor**, **William F. Sharpe**, **John Lintner** and **Jan Mossin** independently, building on the earlier work of **Harry Markowitz** on diversification and modern portfolio theory. Sharpe, Markowitz and Merton Miller jointly received the 1990 Nobel Memorial Prize in Economics for this contribution to the field of financial economics. [wikipedia](https://en.wikipedia.org/wiki/Capital_asset_pricing_model)

The model is the next: 

$$E(R_i) = R_f + \beta_i  (E(R_m)- R_f)$$

Where: 

$E(R_i) =$ *Is the expected return on the capital asset*

$R_f =$ *Is the risk-free rate of interest*

$\beta_i =$ *Is the beta of the capital asset, which is in our linear model* $\hat{\beta_i} = Cor(Y,X) \frac{Sd(Y)}{Sd(X)}$

$R_m =$ *Is the expected return of the market*



## The Interpretation


* CAPM helps investors calculate risk and what type of return they should expect on their investment. 


* In our model, the $\beta_i$ it's a measure of the volatility, or systematic risk, of a security or a portfolio in comparision to the market as a whole, in this case we are using the [IPC](http://www.bmv.com.mx/en/indices/main/) as the whole market,  and its [components](http://www.bmv.com.mx/en/markets/special-information). 

* Beta is calculated using regression analysis, and you can think of beta as the tendency of a security's returns to respond to swings in the market. a beta of 1 indicates that the security's price will move with the market. A beta of less than 1 means that the security will be less volatile than the market. A beta greater than 1 indicates that the security's price will be less volatile than the market. For example, if a stock's __beta__ is 1.2, it's theoretically 20% more volatile than the market. [investopedia](http://www.investopedia.com/terms/b/beta.asp?utm_term=beta&utm_content=sem-unp&utm_medium=organic&utm_source=&utm_campaign=&ad=&an=&am=&o=40186&askid=&l=dir&qsrc=999&qo=investopediaSiteSearch)


## Notes on the Visualizations

* ___For the returns we use a history for one year and at the close of March___ 

* In the graph **"Betas"** it shows the nivel of the Beta, which is an order of quantile of the table named **"Table of CAPM"** the size of the Bubble its the CAPM, which is the return on the capital asset, in the graph you will also zoom it and export the image. 

* We have a Checbox called **"Nivels of Beta"** which is our input to see the rest of our app, its related with the **"Table of CAPM"** and also with the graph **"BETAS"**.

* The table **"Table of CAPM"** its the output of our model, also we have two boxes where you can insert two inputs one is the  $R_f =$  *risk-free rate of interest*  the other is $R_m =$ *expected return of the market* both are necessry for the model and impacts the CAPM1 that it is in the table, and also this table we can download.

* The section "By Sector" shows a bar and a pie, grouped by the sector to the assets in the IPC, tha bar shows the [Market Cap](http://www.investopedia.com/articles/basics/03/031703.asp) which is  just a fancy name for a straightforward concept: it is the market value of a company's outstanding shares. The pie is just the distribution of the number of assets into the sectors. 
