
Graded Assessment: MongoDB Scripts with Relationships

Scenario Overview:

You are working with an e-commerce platform. The platform has two collections:

1.	Customers collection: Contains information about each customer.
2.	Orders collection: Contains information about orders placed by customers.

Each customer can have multiple orders, but each order is linked to only one customer.

Customer Document Structure:

{ "_id": ObjectId("unique_id"), "name": "John Doe", "email": "johndoe@example.com", "address": { "street": "123 Main St", "city": "Springfield", "zipcode": "12345" }, "phone": "555-1234", "registration_date": ISODate("2023-01-01T12:00:00Z") }

Order Document Structure:
{ "_id": ObjectId("unique_id"), "order_id": "ORD123456", "customer_id": ObjectId("unique_customer_id"), // Reference to a Customer document "order_date": ISODate("2023-05-15T14:00:00Z"), "status": "shipped", "items": [ { "product_name": "Laptop", "quantity": 1, "price": 1500 }, { "product_name": "Mouse", "quantity": 2, "price": 25 } ], "total_value": 1550 }


Open the command prompt/terminal to start the server:

C:\Users\JAGANNATH>mongosh

test> show collections

test> use sampledb


Part 1: Basic MongoDB Commands and Queries

Objective: Understand and demonstrate basic CRUD operations on collections with relationships.

Instructions: Write MongoDB scripts for the following tasks:

1. Create the Collections and Insert Data:

	i. Create two collections: customers and orders.

	sampledb> db.createCollection("customers");
	{ ok: 1 }
	
	sampledb> db.createCollection("orders");
	{ ok: 1 }
	
	-- To see collections:

	sampledb> show collections
	customers
	orders
	
o	Insert 5 customer documents into the customers collection.

	sampledb> db.customers.insertMany([
		{ "_id": ObjectId(), name: "Jagan", email: "jagan@example.com", address: { street: "123 JC Colony", city: "Bangaluru", zipcode: "12345" }, phone: "555-1234", registration_date: ISODate("2023-01-01T12:00:00Z") },
		{ "_id": ObjectId(), name: "Harsha", email: "harsha@example.com", address: { street: "456 Bari Nagar", city: "Hyderabad", zipcode: "54321" }, phone: "9555897890", registration_date: ISODate("2023-02-15T12:00:00Z") },
		{ "_id": ObjectId(), name: "Hari", email: "hari@example.com", address: { street: "789 NGO Colony", city: "Chennai", zipcode: "515591" }, phone: "9155598765", registration_date: ISODate("2023-03-10T12:00:00Z") },
		{ "_id": ObjectId(), name: "Balaji", email: "balaji@example.com", address: { street: "980 Police Line", city: "Kolkata", zipcode: "515341" }, phone: "9978965723", registration_date: ISODate("2023-04-20T12:00:00Z") },
		{ "_id": ObjectId(), name: "Ram", email: "ram@example.com", address: { street: "768 Tippu Nagar", city: "Mumbai", zipcode: "76543" }, phone: "9789345678", registration_date: ISODate("2023-05-05T12:00:00Z") }
	]);

	output:
		{
		  acknowledged: true,
		  insertedIds: {
			'0': ObjectId('67338368e26dc70df50d8195'),
			'1': ObjectId('67338368e26dc70df50d8196'),
			'2': ObjectId('67338368e26dc70df50d8197'),
			'3': ObjectId('67338368e26dc70df50d8198'),
			'4': ObjectId('67338368e26dc70df50d8199')
		  }
		}

	sampledb> db.customers.find().pretty();
	output:
		[
		  {
			_id: ObjectId('67338368e26dc70df50d8195'),
			name: 'Jagan',
			email: 'jagan@example.com',
			address: { street: '123 JC Colony', city: 'Bangaluru', zipcode: '12345' },
			phone: '555-1234',
			registration_date: ISODate('2023-01-01T12:00:00.000Z')
		  },
		  {
			_id: ObjectId('67338368e26dc70df50d8196'),
			name: 'Harsha',
			email: 'harsha@example.com',
			address: { street: '456 Bari Nagar', city: 'Hyderabad', zipcode: '54321' },
			phone: '9555897890',
			registration_date: ISODate('2023-02-15T12:00:00.000Z')
		  },
		  {
			_id: ObjectId('67338368e26dc70df50d8197'),
			name: 'Hari',
			email: 'hari@example.com',
			address: { street: '789 NGO Colony', city: 'Chennai', zipcode: '515591' },
			phone: '9155598765',
			registration_date: ISODate('2023-03-10T12:00:00.000Z')
		  },
		  {
			_id: ObjectId('67338368e26dc70df50d8198'),
			name: 'Balaji',
			email: 'balaji@example.com',
			address: { street: '980 Police Line', city: 'Kolkata', zipcode: '515341' },
			phone: '9978965723',
			registration_date: ISODate('2023-04-20T12:00:00.000Z')
		  },
		  {
			_id: ObjectId('67338368e26dc70df50d8199'),
			name: 'Ram',
			email: 'ram@example.com',
			address: { street: '768 Tippu Nagar', city: 'Mumbai', zipcode: '76543' },
			phone: '9789345678',
			registration_date: ISODate('2023-05-05T12:00:00.000Z')
		  }
		]
		
	ii. Insert 5 order documents into the orders collection, each linked to a customer using the customer_id field (the _id of a customer document).
	
	sampledb> db.orders.insertMany([
		{ "_id": ObjectId(), "order_id": "ORD123011", "customer_id": ObjectId('67338368e26dc70df50d8195'), "order_date": ISODate("2023-02-10T14:10:00Z"), "status": "shipped",   "items": [{ "product_name": "Laptop", "quantity": 1, "price": 50000 }, { "product_name": "Mouse", "quantity": 2, "price": 1000 }], "total_value": 52000 },
		{ "_id": ObjectId(), "order_id": "ORD123012", "customer_id": ObjectId('67338368e26dc70df50d8196'), "order_date": ISODate("2023-03-12T14:20:00Z"), "status": "delivered", "items": [{ "product_name": "Mobile", "quantity": 1, "price": 16000 }], "total_value": 16000 },
		{ "_id": ObjectId(), "order_id": "ORD123013", "customer_id": ObjectId('67338368e26dc70df50d8197'), "order_date": ISODate("2023-04-14T14:30:00Z"), "status": "pending",   "items": [{ "product_name": "Smart Watch", "quantity": 1, "price": 1500 }], "total_value": 1500 },
		{ "_id": ObjectId(), "order_id": "ORD123014", "customer_id": ObjectId('67338368e26dc70df50d8198'), "order_date": ISODate("2023-05-16T14:40:00Z"), "status": "shipped",   "items": [{ "product_name": "Bluetooth", "quantity": 1, "price": 12000 }, { "product_name": "Speaker", "quantity": 2, "price": 2500 }], "total_value": 17000 },
		{ "_id": ObjectId(), "order_id": "ORD123015", "customer_id": ObjectId('67338368e26dc70df50d8199'), "order_date": ISODate("2023-06-18T14:50:00Z"), "status": "shipped",   "items": [{ "product_name": "Headphones", "quantity": 1, "price": 1200 }, { "product_name": "Charger", "quantity": 1, "price": 300 }], "total_value": 1500 }
	]);
	
    output:
		{
		  acknowledged: true,
		  insertedIds: {
			'0': ObjectId('67338bf1e26dc70df50d819a'),
			'1': ObjectId('67338bf1e26dc70df50d819b'),
			'2': ObjectId('67338bf1e26dc70df50d819c'),
			'3': ObjectId('67338bf1e26dc70df50d819d'),
			'4': ObjectId('67338bf1e26dc70df50d819e')
		  }
		}
	
	sampledb> db.orders.find().pretty();
	
	output:
		[
		  {
			_id: ObjectId('67338bf1e26dc70df50d819a'),
			order_id: 'ORD123011',
			customer_id: ObjectId('67338368e26dc70df50d8195'),
			order_date: ISODate('2023-02-10T14:10:00.000Z'),
			status: 'shipped',
			items: [
			  { product_name: 'Laptop', quantity: 1, price: 50000 },
			  { product_name: 'Mouse', quantity: 2, price: 1000 }
			],
			total_value: 52000
		  },
		  {
			_id: ObjectId('67338bf1e26dc70df50d819b'),
			order_id: 'ORD123012',
			customer_id: ObjectId('67338368e26dc70df50d8196'),
			order_date: ISODate('2023-03-12T14:20:00.000Z'),
			status: 'delivered',
			items: [ { product_name: 'Mobile', quantity: 1, price: 16000 } ],
			total_value: 16000
		  },
		  {
			_id: ObjectId('67338bf1e26dc70df50d819c'),
			order_id: 'ORD123013',
			customer_id: ObjectId('67338368e26dc70df50d8197'),
			order_date: ISODate('2023-04-14T14:30:00.000Z'),
			status: 'pending',
			items: [ { product_name: 'Smart Watch', quantity: 1, price: 1500 } ],
			total_value: 1500
		  },
		  {
			_id: ObjectId('67338bf1e26dc70df50d819d'),
			order_id: 'ORD123014',
			customer_id: ObjectId('67338368e26dc70df50d8198'),
			order_date: ISODate('2023-05-16T14:40:00.000Z'),
			status: 'shipped',
			items: [
			  { product_name: 'Bluetooth', quantity: 1, price: 12000 },
			  { product_name: 'Speaker', quantity: 2, price: 2500 }
			],
			total_value: 17000
		  },
		  {
			_id: ObjectId('67338bf1e26dc70df50d819e'),
			order_id: 'ORD123015',
			customer_id: ObjectId('67338368e26dc70df50d8199'),
			order_date: ISODate('2023-06-18T14:50:00.000Z'),
			status: 'shipped',
			items: [
			  { product_name: 'Headphones', quantity: 1, price: 1200 },
			  { product_name: 'Charger', quantity: 1, price: 300 }
			],
			total_value: 1500
		  }
		]
	
2.	Find Orders for a Specific Customer:
	
	i. Write a script to find all orders placed by a customer with the name “John Doe”. Use the customer’s _id to query the orders collection.
	
	sampledb> const jagannath = db.customers.findOne({ "name": "Jagan" });
	sampledb> db.orders.find({ "customer_id": jagannath._id });
	
	output:
	[
	  {
		_id: ObjectId('67338bf1e26dc70df50d819a'),
		order_id: 'ORD123011',
		customer_id: ObjectId('67338368e26dc70df50d8195'),
		order_date: ISODate('2023-02-10T14:10:00.000Z'),
		status: 'shipped',
		items: [
		  { product_name: 'Laptop', quantity: 1, price: 50000 },
		  { product_name: 'Mouse', quantity: 2, price: 1000 }
		],
		total_value: 52000
	  }
	]

3. Find the Customer for a Specific Order:

	i. Write a script to find the customer information for a specific order (e.g., order_id = “ORD123456”).

	sampledb> const order = db.orders.findOne({ "order_id": "ORD123011" });

	sampledb> db.customers.findOne({ "_id": order.customer_id });

	Output:
	{
	  _id: ObjectId('67338368e26dc70df50d8195'),
	  name: 'Jagan',
	  email: 'jagan@example.com',
	  address: { street: '123 JC Colony', city: 'Bangaluru', zipcode: '12345' },
	  phone: '555-1234',
	  registration_date: ISODate('2023-01-01T12:00:00.000Z')
	}


4. Update Order Status:

	i. Write a script to update the status of an order to “delivered” where the order_id is “ORD0001”.

	sampledb> db.orders.updateOne(
			{ "order_id": "ORD123011" },
			{ $set: { "status": "delivered" } }
		);

	Output:
	{
	  acknowledged: true,
	  insertedId: null,
	  matchedCount: 1,
	  modifiedCount: 1,
	  upsertedCount: 0
	}

	sampledb> db.orders.findOne({ "order_id": "ORD123011" });
	output:
		{
		  _id: ObjectId('67338bf1e26dc70df50d819a'),
		  order_id: 'ORD123011',
		  customer_id: ObjectId('67338368e26dc70df50d8195'),
		  order_date: ISODate('2023-02-10T14:10:00.000Z'),
		  status: 'delivered',
		  items: [
			{ product_name: 'Laptop', quantity: 1, price: 50000 },
			{ product_name: 'Mouse', quantity: 2, price: 1000 }
		  ],
		  total_value: 52000
		}

5. Delete an Order:

	i. Write a script to delete an order where the order_id is “ORD0001”.

	sampledb> db.orders.deleteOne({ "order_id": "ORD123011" });

	Output:
	{ acknowledged: true, deletedCount: 1 }


Part 2: Aggregation Pipeline

Objective: Use MongoDB’s aggregation framework to perform more advanced queries, including working with related data across collections.

Instructions: Use the aggregation framework to solve the following tasks:

1. Calculate Total Value of All Orders by Customer:

	i. Write a script to calculate the total value of all orders for each customer. This should return each customer’s name and the total order value.

	sampledb> db.orders.aggregate([
			 { $group: { _id: "$customer_id", total_spent: { $sum: "$total_value" } } },
			 { $lookup: { from: "customers", localField: "_id", foreignField: "_id", as: "customer_info" } },
			 { $unwind: "$customer_info" },
			 { $project: { "customer_info.name": 1, total_spent: 1 } }
		 ]);

	Output:
	[
	  {
		_id: ObjectId('67338368e26dc70df50d8198'),
		total_spent: 17000,
		customer_info: { name: 'Balaji' }
	  },
	  {
		_id: ObjectId('67338368e26dc70df50d8196'),
		total_spent: 16000,
		customer_info: { name: 'Harsha' }
	  },
	  {
		_id: ObjectId('67338368e26dc70df50d8199'),
		total_spent: 1500,
		customer_info: { name: 'Ram' }
	  },
	  {
		_id: ObjectId('67338368e26dc70df50d8197'),
		total_spent: 1500,
		customer_info: { name: 'Hari' }
	  }
	]

2. Group Orders by Status:

	i. Write a script to group orders by their status (e.g., “shipped”, “delivered”, etc.) and count how many orders are in each status.

	sampledb> db.orders.aggregate([
			{ $group: { _id: "$status", count: { $sum: 1 } } }
		]);

	Output:
	[
	  { _id: 'delivered', count: 1 },
	  { _id: 'pending', count: 1 },
	  { _id: 'shipped', count: 2 }
	]

3. List Customers with Their Recent Orders:

	i. Write a script to find each customer and their most recent order. Include customer information such as name, email, and order details (e.g., order_id, total_value).

	sampledb> db.orders.aggregate([
			 { $sort: { "order_date": -1 } },
			 { $group: { _id: "$customer_id", latest_order: { $first: "$$ROOT" } } },
			 { $lookup: { from: "customers", localField: "_id", foreignField: "_id", as: "customer_info" } },
			 { $unwind: "$customer_info" },
			 { $project: { "customer_info.name": 1, "customer_info.email": 1, "latest_order.order_id": 1, "latest_order.total_value": 1 } }
		 ]);
		 
	output:
	[
	  {
		_id: ObjectId('67338368e26dc70df50d8196'),
		latest_order: { order_id: 'ORD123012', total_value: 16000 },
		customer_info: { name: 'Harsha', email: 'harsha@example.com' }
	  },
	  {
		_id: ObjectId('67338368e26dc70df50d8198'),
		latest_order: { order_id: 'ORD123014', total_value: 17000 },
		customer_info: { name: 'Balaji', email: 'balaji@example.com' }
	  },
	  {
		_id: ObjectId('67338368e26dc70df50d8197'),
		latest_order: { order_id: 'ORD123013', total_value: 1500 },
		customer_info: { name: 'Hari', email: 'hari@example.com' }
	  },
	  {
		_id: ObjectId('67338368e26dc70df50d8199'),
		latest_order: { order_id: 'ORD123015', total_value: 1500 },
		customer_info: { name: 'Ram', email: 'ram@example.com' }
	  }
	]

4. Find the Most Expensive Order by Customer:

	i. Write a script to find the most expensive order for each customer. Return the customer’s name and the details of their most expensive order (e.g., order_id, total_value).

	sampledb> db.orders.aggregate([
			 { $sort: { "total_value": -1 } },
			 { $group: { _id: "$customer_id", most_expensive_order: { $first: "$$ROOT" } } },
			 { $lookup: { from: "customers", localField: "_id", foreignField: "_id", as: "customer_info" } },
			 { $unwind: "$customer_info" },
			 { $project: { "customer_info.name": 1, "most_expensive_order.order_id": 1, "most_expensive_order.total_value": 1 } }
		 ]);

	Output:
	[
	  {
		_id: ObjectId('67338368e26dc70df50d8199'),
		most_expensive_order: { order_id: 'ORD123015', total_value: 1500 },
		customer_info: { name: 'Ram' }
	  },
	  {
		_id: ObjectId('67338368e26dc70df50d8196'),
		most_expensive_order: { order_id: 'ORD123012', total_value: 16000 },
		customer_info: { name: 'Harsha' }
	  },
	  {
		_id: ObjectId('67338368e26dc70df50d8198'),
		most_expensive_order: { order_id: 'ORD123014', total_value: 17000 },
		customer_info: { name: 'Balaji' }
	  },
	  {
		_id: ObjectId('67338368e26dc70df50d8197'),
		most_expensive_order: { order_id: 'ORD123013', total_value: 1500 },
		customer_info: { name: 'Hari' }
	  }
	]


Part 3: Real-World Scenario with Relationships

Objective: Apply MongoDB operations to a real-world problem involving two related collections.

Scenario: You are working as a MongoDB developer for an e-commerce platform. The system needs to track customer orders, including the customer’s name, email, and address, as well as the items they ordered.

1. Find All Customers Who Placed Orders in the Last Month:

	i. Write a script to find all customers who have placed at least one order in the last 30 days. Return the customer name, email, and the order date for their most recent order.

	sampledb> const lastMonth = new Date();
	sampledb> lastMonth.setMonth(lastMonth.getMonth() - 1);
	
	output:
		1728754722626
		
	sampledb> db.orders.aggregate([
		   { $match: { "order_date": { $gte: lastMonth } } },
		   { $group: { "_id": "$customer_id", "lastOrderDate": { $max: "$order_date" } } },
		   { $lookup: { from: "customers", localField: "_id", foreignField: "_id", as: "customer" } },
		   { $unwind: "$customer" },
		   { $project: { "customer.name": 1, "customer.email": 1, "lastOrderDate": 1 } }
		 ]);


2. Find All Products Ordered by a Specific Customer:

	i. Write a script to find all distinct products ordered by a customer with the name “John Doe”. Include the product name and the total quantity ordered.

	sampledb> const customer = db.customers.findOne({ "name": "Balaji" });

	sampledb> db.orders.aggregate([
		   { $match: { "customer_id": customer._id } },
		   { $unwind: "$items" },
		   { $group: { "_id": "$items.product_name", "totalQuantity": { $sum: "$items.quantity" } } }
		 ]);

	Output:
	[
	  { _id: 'Bluetooth', totalQuantity: 1 },
	  { _id: 'Speaker', totalQuantity: 2 }
	]

3. Find the Top 3 Customers with the Most Expensive Total Orders:

	i. Write a script to find the top 3 customers who have spent the most on orders. Sort the results by total order value in descending order.

	sampledb> db.orders.aggregate([
	   { $group: { "_id": "$customer_id", "totalOrderValue": { $sum: "$total_value" } } },
	   { $sort: { "totalOrderValue": -1 } },
	   { $limit: 3 },
	   { $lookup: { from: "customers", localField: "_id", foreignField: "_id", as: "customer" } },
	   { $unwind: "$customer" },
	   { $project: { "customer.name": 1, "totalOrderValue": 1 } }
	 ]);

	Output:
	[
	  {
		_id: ObjectId('67338368e26dc70df50d8198'),
		totalOrderValue: 17000,
		customer: { name: 'Balaji' }
	  },
	  {
		_id: ObjectId('67338368e26dc70df50d8196'),
		totalOrderValue: 16000,
		customer: { name: 'Harsha' }
	  },
	  {
		_id: ObjectId('67338368e26dc70df50d8199'),
		totalOrderValue: 1500,
		customer: { name: 'Ram' }
	  }
	]

4. Add a New Order for an Existing Customer:

	i. Write a script to add a new order for a customer with the name “Jane Smith”. The order should include at least two items, such as “Smartphone” and “Headphones”.

	sampledb> const customer = db.customers.findOne({ "name": "Harsha" });

	sampledb> db.orders.insertOne({
	   "order_id": "ORD123016",
	   "customer_id": customer._id,
	   "order_date": ISODate(),
	   "status": "pending",
	   "items": [
	     { "product_name": "Television", "quantity": 1, "price": 8000 },
	     { "product_name": "Tab", "quantity": 1, "price": 1000 }
	   ],
	   "total_value": 9000
	 });

	Output:
		{
		  acknowledged: true,
		  insertedId: ObjectId('67339732e26dc70df50d81a1')
		}

	samplebd> db.customers.findOne({ "name": "Harsha" });
	output:
		{
		  _id: ObjectId('67338368e26dc70df50d8196'),
		  name: 'Harsha',
		  email: 'harsha@example.com',
		  address: { street: '456 Bari Nagar', city: 'Hyderabad', zipcode: '54321' },
		  phone: '9555897890',
		  registration_date: ISODate('2023-02-15T12:00:00.000Z')
		}

	sampledb> db.orders.findOne({ "order_id": "ORD123016" });
	output:
		{
		  _id: ObjectId('67339732e26dc70df50d81a1'),
		  order_id: 'ORD123016',
		  customer_id: ObjectId('67338368e26dc70df50d8196'),
		  order_date: ISODate('2024-11-12T17:58:10.028Z'),
		  status: 'pending',
		  items: [
			{ product_name: 'Television', quantity: 1, price: 8000 },
			{ product_name: 'Tab', quantity: 1, price: 1000 }
		  ],
		  total_value: 9000
		}
		
Part 4: Bonus Challenge

Objective: Demonstrate the ability to work with advanced MongoDB operations and complex relationships.

1. Find Customers Who Have Not Placed Orders:

	i. Write a script to find all customers who have not placed any orders. Return the customer’s name and email.

	Inserting a new customer for better results..

	sampledb> db.customers.insertOne({ "_id": ObjectId(), "name": "Jane Smith", "email": "janesmith@gmail.com", "address": { "street": "456 Elm St", "city": "Metropolis", "zipcode": "67890" }, "phone": "555-5678", "registration_date": ISODate("2023-02-15T09:30:00Z") });
	output:
		{
		  acknowledged: true,
		  insertedId: ObjectId('6733982be26dc70df50d81a2')
		}

	sampledb> db.customers.aggregate([
			 {
				 $lookup: {
					 from: "orders",
					 localField: "_id",
					 foreignField: "customer_id",
					 as: "orders"
				 }
			 },
			 {
				 $match: { "orders": { $size: 0 } }
			 },
			 {
				 $project: {
					 _id: 0,
					 name: 1,
					 email: 1
				 }
			 }
		 ]);

	Output:
		[
		  { name: 'Jagan', email: 'jagan@example.com' },
		  { name: 'Ram', email: 'ram@example.com' },
		  { name: 'Jane Smith', email: 'janesmith@gmail.com' }
		]

2. Calculate the Average Number of Items Ordered per Order:

	i. Write a script to calculate the average number of items ordered per order across all orders. The result should return the average number of items.

	sampledb> db.orders.aggregate([
			 {
				 $project: {
					 numberOfItems: { $size: "$items" }
				 }
			 },
			 {
				 $group: {
					 _id: null,
					 averageItemsPerOrder: { $avg: "$numberOfItems" }
				 }
			 },
			 {
				 $project: {
					 _id: 0,
					 averageItemsPerOrder: 1
				 }
			 }
		 ]);

	Output:
	[ { averageItemsPerOrder: 1.5 } ]

3. Join Customer and Order Data Using $lookup:

	i. Write a script using the $lookup aggregation operator to join data from the customers collection and the orders collection. Return customer name, email, order details (order_id, total_value), and order date.

	sampledb> db.customers.aggregate([
		 {
			 $lookup: {
				 from: "orders",
				 localField: "_id",
				 foreignField: "customer_id",
				 as: "order_details"
			 }
		 },
		 {
			 $unwind: "$order_details"
		 },
		 {
			 $project: {
				 _id: 0,
				 name: 1,
				 email: 1,
				 "order_details.order_id": 1,
				 "order_details.total_value": 1,
				 "order_details.order_date": 1
			 }
		 }
	 ]);

	Output:
	[
	  {
		name: 'Harsha',
		email: 'harsha@example.com',
		order_details: {
		  order_id: 'ORD123012',
		  order_date: ISODate('2023-03-12T14:20:00.000Z'),
		  total_value: 16000
		}
	  },
	  {
		name: 'Harsha',
		email: 'harsha@example.com',
		order_details: {
		  order_id: 'ORD123016',
		  order_date: ISODate('2024-11-12T17:58:10.028Z'),
		  total_value: 9000
		}
	  },
	  {
		name: 'Hari',
		email: 'hari@example.com',
		order_details: {
		  order_id: 'ORD123013',
		  order_date: ISODate('2023-04-14T14:30:00.000Z'),
		  total_value: 1500
		}
	  },
	  {
		name: 'Balaji',
		email: 'balaji@example.com',
		order_details: {
		  order_id: 'ORD123014',
		  order_date: ISODate('2023-05-16T14:40:00.000Z'),
		  total_value: 17000
		}
	  }
	]