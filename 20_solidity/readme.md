it's on the kovan test network.  There are 3 contracts:

AssocatedProfitSplitter: 0x57D67D122d41F0397A5CE25ec29c16aa43BA1526

this contract pulls takes a payment from an account, divides it into 3 equal parts, and then distributes it to our 3 amigos:

pragma solidity ^0.5.0;

// lvl 1: equal split
contract AssociateProfitSplitter {
    // @TODO: Create three payable addresses representing `employee_one`, `employee_two` and `employee_three`.
    address payable employee_one;
    address payable employee_two;
    address payable employee_three;

    constructor(address payable _one, address payable _two, address payable _three) public {
        employee_one = _one;
        employee_two = _two;
        employee_three = _three;
    }

    function balance() public view returns(uint) {
        return address(this).balance;
    }

    function deposit() public payable {
        // @TODO: Split `msg.value` into three
        uint amount = (msg.value/3);
        
        
        // @TODO: Transfer the amount to each employee
        employee_one.transfer(amount);
        employee_two.transfer(amount);
        employee_three.transfer(amount);

        // @TODO: take care of a potential remainder by sending back to HR (`msg.sender`)
        // msg.sender.transfer(msg.value % 3);
        msg.sender.transfer(msg.value - (amount *3));
    }

    function() external payable {
        // @TODO: Enforce that the `deposit` function is called in the fallback function!
        deposit();
    }
}




TieredProfitSplitter: 0x7E70340ec2572aD44eD35dF2Be0E596631C82789

This contract takes money deposited and distributes it based on a percentage as laid out per the 'company'.

pragma solidity ^0.5.0;

// lvl 2: tiered split
contract TieredProfitSplitter {
    address payable employee_one; // ceo
    address payable employee_two; // cto
    address payable employee_three; // bob

    constructor(address payable _one, address payable _two, address payable _three) public {
        employee_one = _one;
        employee_two = _two;
        employee_three = _three;
    }

    // Should always return 0! Use this to test your `deposit` function's logic
    function balance() public view returns(uint) {
        return address(this).balance;
    }

    function deposit() public payable {
        uint points = msg.value / 100; // Calculates rudimentary percentage by dividing msg.value into 100 units
        uint total;
        uint amount;

        // @TODO: Calculate and transfer the distribution percentage
        // Step 1: Set amount to equal `points` * the number of percentage points for this employee
        // Step 2: Add the `amount` to `total` to keep a running total
        // Step 3: Transfer the `amount` to the employee

        // @TODO: Repeat the previous steps for `employee_two` and `employee_three`
        // ceo points
        amount = points * 60;
        total =points += amount;
        employee_one.transfer(amount);
        
        // cto points
        amount = points * 25;
        total =points += amount;
        employee_two.transfer(amount);
        
        // bob points
        amount = points * 15;
        total =points += amount;
        employee_three.transfer(amount);
        

        employee_one.transfer(msg.value - total); // ceo gets the remaining wei
    }

    function() external payable {
        deposit();
    }
}



DeferredEquityPlan: 0xB5cbF6F4981C2891C3FFBbF264104Af9DfA1Bbaa

This contract is for a deffered share program that pays out a quarter of the award amount per year over 4 years.  

pragma solidity ^0.5.0;

// lvl 3: equity plan
contract DeferredEquityPlan {
    address human_resources;

    address payable employee; // bob
    bool active = true; // this employee is active at the start of the contract

    // @TODO: Set the total shares and annual distribution
    uint fakenow = now;
    uint total_shares = 1000;
    uint annual_distribution = 250; //  1000/4 years

    uint start_time = now; // permanently store the time this contract was initialized
    // uint start_time = fakenow;

    // @TODO: Set the `unlock_time` to be 365 days from now
    uint unlock_time = now + 365 days;
    // uint unlock_time = fakenow + 365 days;

    uint public distributed_shares; // starts at 0

    constructor(address payable _employee) public {
        human_resources = msg.sender;
        employee = _employee;
    }

    function distribute() public {
        require(msg.sender == human_resources || msg.sender == employee, "You are not authorized to execute this contract.");
        require(active == true, "Contract not active.");

        // @TODO: Add "require" statements to enforce that:
        require(unlock_time <= now, "Shares have not yet vested");
        // require(unlock_time <= fakenow, "Shares have not yet vested");
        require(distributed_shares < total_shares, "Shares greater than allocated shares");

        // @TODO: Add 365 days to the `unlock_time`
        unlock_time += 365;

        // @TODO: Calculate the shares distributed by using the function (now - start_time) / 365 days * the annual distribution
        // Make sure to include the parenthesis around (now - start_time) to get accurate results!
        (now - start_time)/ 365 days * annual_distribution;
        // (fakenow - start_time)/ 365 days * annual_distribution;
        
        

        // double check in case the employee does not cash out until after 5+ years
        if (distributed_shares > 1000) {
            distributed_shares = 1000;
        }
    }

    // human_resources and the employee can deactivate this contract at-will
    function deactivate() public {
        require(msg.sender == human_resources || msg.sender == employee, "You are not authorized to deactivate this contract.");
        active = false;
    }

    // Since we do not need to handle Ether in this contract, revert any Ether sent to the contract directly
    function() external payable {
        revert("Do not send Ether to this contract!");
    }
    
    // function fastforward() public {
    //     fakenow+= 100 days;
    // }
}
