
%Read in the table of orders
Orders = readtable('purchasing_order.csv'); 

%Find the returned orders only
ReturnsOnly = Orders(strcmp(Orders.Return, 'Y'), :);

%Find the unique customers who have ever returned anything
CustomerIDs = unique(ReturnsOnly.Customer_ID);

%Find only the orders of the corresponding customers and rating > 0
Orders = Orders(ismember(Orders.Customer_ID, CustomerIDs), :);
Orders = Orders(Orders.Rating > 0, :);


p = strcmp(Orders.Return, 'Y');
h = Orders.Rating;

lr_par = fminsearch(@(a)logreg(a,h,p),[0 0]);

hx = linspace(0,5,1000);

plot(h,p,'*',hx,1./(1+exp(-lr_par(1)*hx-lr_par(2))));
lg = legend('Raw Data','Logistic Regression');
axis([0 6 -0.1 1.1]);
xticks([1:5]);
yticks([0 1]);
yticklabels({'No', 'Yes'})
xlabel('Rating');
ylabel('Return');

%The logistic regression algorithm
function S = logreg(a,h,p)  % a = [a , b]

S = 0;
for k = 1:length(h)
    S = S + (p(k)-1/(1+exp(-a(1)*h(k)-a(2))))^2;
end

end
