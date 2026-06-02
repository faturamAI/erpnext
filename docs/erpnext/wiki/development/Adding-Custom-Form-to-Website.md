To add a custom form to the website, you can create the form in HTML and then use the `erpnext.send_message` function via javascript to create a new Lead (or update existing one).

### Example

#### HTML (Content)

In the Content, click on HTML to compose a form:

    <div class="help">Your Company Name</div>
    <input name="company_name" type="text" placeholder="My Company" /> <br /><br />
    <div class="help">Your Name</div>
    <input name="sender_name" type="text" placeholder="Jane Doe" /> <br /><br />
    <div class="help">Your Email</div>
    <input name="email" type="text" placeholder="jane_doe@example.com" /> <br /><br />
    <div class="help">Your Phone Number</div>
    <input name="phone" type="text" placeholder="12345676" /> <br /><br />
    <div class="help">Which Product are you interested in?</div>
    <select name="product">
        <option value="Product 1">Product 1</option>
        <option value="Product 2">Product 2</option>
        <option value="Product 3">Product 3</option>
    </select>
    <br /><br />
    <div id="form-alert" class="alert" style="display: none; margin-bottom: 10px;"></div>
    <button class="btn btn-success btn-request">Send Inquiry</button><br />

#### Script (JS)

	$(document).ready(function() {
  
	  // button for sign-up event
  
	  $('.btn-request').click(function() {

	    // hide any message
	    $("#form-alert").toggle(false);

	    var args = {
	        sender_name: $('[name="sender_name"]').val(),
	        company_name: $('[name="company_name"]').val(),
	        email: $('[name="email"]').val(),
	        phone: $('[name="phone"]').val(),
	        product: $('[name="product"]').val(),
	      }

	    // all mandatory
	    if(!(args.sender_name && args.company_name && args.email
	        && args.phone)) {
	       msgprint("All fields are necessary. Please try again.");
	       return;
	    }
    
	    // email is valid
	    if(!valid_email(args.email)) {
	        msgprint('Please enter a valid email id');
	        return;
	    }

	    // compose the message
	    var message = "Company: " + args.company_name + "\n"
	        + "Name: " + args.sender_name + "\n"
	        + "Email: " + args.email + "\n"
	        + "Phone: " + args.phone + "\n"
	        + "Product: " + args.product

	    erpnext.send_message({
	      subject:'New Website Query',
	      sender: $('[name="email"]').val(),
	      status: 'Open',
	      message: message,
	      callback: function(r) {
                // print return message
	        msgprint(r.message);

                // clear all inputs
	        $(':input').val('');
	      }
	    });
	  });
  
	});

	var msgprint = function(txt) {
	    $("#form-alert").html(txt).toggle(true);
	}