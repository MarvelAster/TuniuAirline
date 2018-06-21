var express = require("express")
    app = express(),
    braintree = require("braintree"),
    bodyparser = require("body-parser");
    
var gateway = braintree.connect({
    environment:  braintree.Environment.Sandbox,
    merchantId:   'htcsvs4ys3s72593',
    publicKey:    '3kw983j7rvtgc6pj',
    privateKey:   '0f416403aa4b4498d761bc301b1d2bf9'
});
app.use(bodyparser.urlencoded())
app.post("/checkout", function (req, res) {
    var nonceFromTheClient = req.body.payment_method_nonce;
    gateway.transaction.sale({
        amount: req.body.amount,
        paymentMethodNonce: nonceFromTheClient,
        options: {
          submitForSettlement: true
        }
      }, function (err, result) {
        res.json(result)
      });
  });



app.listen(8000, function() {
    console.log("got it!")
})