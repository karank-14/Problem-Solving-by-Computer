%Read in the table of orders
Orders = readtable('purchasing_order.csv'); 

%Find the category C only and sort the table by ID
Orders = Orders(strcmp(Orders.Product_Category, 'C'), :);
Orders = sortrows(Orders,{'Customer_ID'});

noOfOrders = height(Orders);

CustomerIDs = unique(Orders.Customer_ID);
noOfCustomers = length(CustomerIDs);

Ranking = zeros(noOfCustomers, 4);

x = 1;
totalValue = 0;
OrderCnt = 0;
AvgRating = 0;

noOfOrders = height(Orders);

for count = 1:noOfCustomers
    while(Orders.Customer_ID(x) == CustomerIDs(count))
        
        totalValue = totalValue + Orders.Product_Value(x);
        OrderCnt = OrderCnt + 1;
        
        AvgRating = AvgRating + Orders.Rating(x);

        
        if (x < noOfOrders)
          x = x + 1;
        end
        if (x == noOfOrders)
         break;
        end
    end
    
    %Track the ID, their average order value and rating
    Ranking(count, 1) = CustomerIDs(count);
    Ranking(count, 2) = totalValue / OrderCnt;
    Ranking(count, 3) = AvgRating / OrderCnt;

    totalValue = 0;
    OrderCnt = 0;
    AvgRating = 0;
end
format long

maxValue = max(Ranking(:, 2));
maxRating = max(Ranking(:, 3));

%Normalise the average orders and ratings and add them together
for count = 1: noOfCustomers
   Ranking(count, 2) = Ranking(count, 2) / maxValue;
   Ranking(count, 3) = Ranking(count, 3) / maxRating;
   Ranking(count, 4) = Ranking(count, 2) + Ranking(count, 3);
end

%Rank them from highest total to lowest
Ranking = sortrows(Ranking, 4,'descend');
