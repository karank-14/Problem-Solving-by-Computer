%Read in the table of orders
Orders = readtable('purchasing_order.csv'); 

%Find the returned orders only
ReturnsOnly = Orders(strcmp(Orders.Return, 'Y'), :);

%Find the unique customers who have ever returned anything
CustomerIDs = unique(ReturnsOnly.Customer_ID);
CustomerIDs = sortrows(CustomerIDs);
noOfCustomers = length(CustomerIDs);

%Find only the orders of the corresponding customers
Orders = Orders(ismember(Orders.Customer_ID, CustomerIDs), :);

%Sort by CustomerID then Date
sortedOrders = sortrows(Orders,{'Customer_ID','Date'});

probabilties = zeros(noOfCustomers, 1);
x = 1;
noOfOrders = height(sortedOrders);
returnFound = 0;
totalValue = 0;
valueAfterReturn = 0;

for count = 1:noOfCustomers
    while(sortedOrders.Customer_ID(x) == CustomerIDs(count))
     
     %Check if we have found the returned order yet
     if (strcmp(sortedOrders.Return(x), 'Y') == 1)
         returnFound = 1;
     end
     
     %Total value of orders without the returned order
     if (strcmp(sortedOrders.Return(x), 'Y') == 0)
     totalValue = totalValue + sortedOrders.Product_Value(x);
     end
     
     %Value of orders after the returned order
     if (returnFound == 1 && strcmp(sortedOrders.Return(x), 'Y') == 0)
         valueAfterReturn = valueAfterReturn + sortedOrders.Product_Value(x);
     end
     
     if (x < noOfOrders)
         x = x + 1;
     end
     if (x == noOfOrders)
         break;
     end
    end
     
     %Caluclate the probabibility
     probabilties(count, 1) = valueAfterReturn / totalValue;
     
     %Reset values for the next customer
     totalValue = 0;
     valueAfterReturn = 0;
     returnFound = 0;
end

%Find the mean of the probabilities
meanReturns = mean(probabilties);