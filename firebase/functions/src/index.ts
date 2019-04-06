import * as functions from "firebase-functions"
import * as express from "express"
import * as bodyParser from "body-parser"
var stripe = require('stripe')('sk_test_81YGtXDec2X4QiH1VIx2XrW1')
// import * as stripe from "stripe"

/* Express */
const app1 = express()
app1.use(bodyParser.json());
app1.use(bodyParser.urlencoded({
    extended : true
}));

app1.post('/charge', (req, res) => {
  const customer = req.body.customer;
  const amount   = req.body.amount;
  const currency = req.body.currency;


  // This function assumes that some previous middleware has determined the
  // correct customerId for the session and saved it on the request object.
  stripe.charges.create(
    {customer : customer,
     amount   :  amount,
     currency : currency 
    },function(err, charge){
      if(err) {
        console.log(err, req.body)
        res.status(500).end();
      } else {
           res.status(200).send()
      }

    }
  )
});

app1.post('/charge_nocustomer', (req, res) => {
  const amount   = req.body.amount;
  const currency = req.body.currency;


  // This function assumes that some previous middleware has determined the
  // correct customerId for the session and saved it on the request object.
  stripe.charges.create(
    {amount   :  amount,
     currency : currency 
    },function(err, charge){
      if(err) {
        console.log(err, req.body)
        res.status(500).end();
      } else {
           res.status(200).send()
      }

    }
  )
});

app1.post('/new_customer', (req, res) => {
  const email = req.body.email;

  stripe.customers.create({ 
    email: req.body.email },
     function(err, customer) {

      if(err) {
        console.log(err, req.body)
        res.status(500).end();
      } else {
        console.log(customer, req.body)
        res.status(200).send(customer)
      }
   
    }
  );
});

app1.post('/ephemeral_keys', (req, res) => {
    const stripe_version = req.body.api_version;
    const customer_id     = req.body.customer_id;
    if (!stripe_version) {
      res.status(400).end();
      return;
    }
    // This function assumes that some previous middleware has determined the
    // correct customerId for the session and saved it on the request object.
    stripe.ephemeralKeys.create(
      {customer: customer_id},
      {stripe_version: stripe_version}
    ).then((key) => {
      res.status(200).json(key);
    }).catch((err) => {
      res.status(500).end();
    });
  });

  app1.post('/ephemeral_keys_nocustomer', (req, res) => {
    const stripe_version = req.body.api_version;
  
    if (!stripe_version) {
      res.status(400).end();
      return;
    }
    // This function assumes that some previous middleware has determined the
    // correct customerId for the session and saved it on the request object.
    stripe.ephemeralKeys.create(
      {stripe_version: stripe_version}
    ).then((key) => {
      res.status(200).json(key);
    }).catch((err) => {
      res.status(500).end();
    });
  });

const api1 = functions.https.onRequest(app1)

module.exports = {
  api1
}