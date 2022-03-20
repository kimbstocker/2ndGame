# R7. Identification of the problem you are trying to solve by building this particular marketplace app.

There is a gap in Australia for a good marketplace application that specializes in Board games and other games trade. At the moment, casual users' second hand marketplace is prominently Facebook marketplace and Gumtree. The monopoly needs to be challenged and Facebook & Gumtree is offering a platform where users spend a lot of time administering their listings. It is inconvenient and time consuming to buy and sell. 2ndGame marketplace application will handle payment and help sellers avoid the hassle of dealing with buyers trying to haggle for a bargain. When users look for an item, they can purchase directly through the app and sellers will be notified to send the item to the buyer directly. 2ndGame offers something that other marketplaces do not. 

# R8. Why is it a problem that needs solving?

Monopoly is not good for the consumers and a well designed and organized marketplace is much needed in Australia. New board games are not cheap for their users (mainly students), board games do not need to be new to be enjoyable and users/players can benefit from playing different games instead of one or two that they can afford. 

# R9. A link (URL) to your deployed app (i.e. website)

[2Game URL](https://buysell2game.herokuapp.com/)

# R10. A link to your GitHub repository (repo).

[GitHub Repo](https://github.com/kimbstocker/KimStocker_T2A2)

# R11. Description of your marketplace app (website), including:

## Purpose

There is a gap in the market for a marketplace for second hand board games. Furthermore, new board games are expensive for their primary market - students. Additionally, a lot of board game owners have unused or like-new board games in their collection and might want to get rid of it for a fair price. This is where 2ndGame marketplace web application comes in. It also provide a community platform for like-minded users to socialize and simply get together to play board games. 

## Functionality / features

2ndGame marketplace web app allows users to buy and sell their new, used, old board games and buy good quality, value for money new/second hand board games. Additionally, users can join a community forum and talk to like-minded others or even set up a time and place for a board games session. Below is some of the main features offered by the web app
- Shop by category.
- Create a user account.
- Create a listing.
- Update details of a listed item. Once the listing is sold, the user can only update the shipping receipt, they can not change other details.
- Update shipping receipt once the listing is sold to another user.
- View their listed items.
- Delete their items off the marketplace. This function is only possible when the listing has not been sold.
- Add an item to their favourite list
- View their favourite items list.
- Buy an item: add to cart and check out via stripe payment.
- View history and status of their orders.
  
## Sitemap

![Sitemap](docs/Kim_Stocker_T2A2_SiteMap.pdf "Sitemap")

## Screenshots


## Target audience

The target audience of this market place is mainly students. However, it can be used by mums, dad, families, and all board game lovers. If the business model is successful, it can be scaled up and the target audience can be expanded to everyone who has a electronic device and internet.

## Tech stack (e.g. html, css, deployment platform, etc)

- The application is built on 
- Ruby on Rails
- Html
- Bootstrap
- CSS, SCSS
- Heroku deployment platform
- Javascript
  
# R12. User stories for your app

- As a seller, i want to be able to sell my used board games so I can get some money for unused stuff that i own.
- As a buyer, i want to be able to buy board games so I can enjoy playing with my friends and families.
- As a buyer, i want to be able to see the condition of the board games because i dont want to buy incompleted or bad quality items.
- As a buyer, i want to be able to negotiate the price of the board games so that i can save some money, pay less.
- As a seller, i want to be able to edit the price in case im unable to sell with the current price so I can eventually sell it.
- As a buyer, I want to buy from a trusted seller whose products match his condition description. They should have good customer ratings so i can trust what the condition matches the actual item.
- As a buyer, I want to see the shipping status of my purchase so I know when to expect it.
- As a buyer, i want to be able to make payment securely because I dont want my credit card details being stolen by hackers.
- As a seller, I want to get my payment as soon as possible. As soon as I upload the shipping receipt, i want to get my payment so I feel secured with my money.
- As a buyer, I want to be able to search for what I am looking for quickly so i dont waste time browsing and potentially buy what i dont actually need.

# R13. Wireframes for your app

![Wireframes](docs/KimStocker_T2A2_Wireframes.pdf "Wireframes")

# R14. An ERD for your app

![ERD](docs/KimStocker_T2A2_ERD "ERD")

# R15. Explain the different high-level components (abstractions) in your app

The application is developed using the Model View Controller structure. The Model handles data logic and communication with the database system. The Model is responsible to select and modify the content for uses by the Controller. The Model also sets the database structure of the app as well as validating some of the incoming data input by the user. The Model is also responsible for the entity relationship between the content objects e.g. an user can have many listings but a listing can only belong to one and only one user. 

The View handles user interface and is supported by bootstrap styling gem. The representation of data can be dynamic based on the user request through params received.

The Controller handles user interface/API actions and applications. The Controller controls the flow of the request and Model manipulation. It does not handle data logic.

When a user uses a web browser to send a request to the web server, rails checks routes.rb to match and routes the URL & HTML methods request to a predetermined action that is predefined in a Controller (with the same name convention). For example, when a user clicks on the Category/Shop all nav-link, the request goes to Routes.rb where it finds the first matched URL method and link (in this case, GET method to listings/category/:id link). It then route the request to the appropriate controller set after the “to:” keyword, in this case “listings#index”. In the listings_controller, under index method, certain actions are performed to collect data from the Listing and render that data through index.html.erb from the View\listings file.

# R16. Detail any third party services that your app will use

The application is hosted on Heroku server using staging and production set up where the staging app is separated from production but can be promoted to production if the staging app is successfully built with no error. 

The application also uses third party Amazon Web Services to store images uploaded by the users. When a user uploads an image, the image is uploaded to a S3 bucket (the server is located in a set region, in this case, south east region).

Another third party service the app is using is Stripe for customers payments handling. When a user clicks the “proceed to check out” button in their order, they will be rerouted to the Stripe checkout session where Stripe handles payment received for the application. Stripe then uses Webhook to send back event details such as invoice, checkout session details eg. complete, expire etc. Those details can be beneficial when it comes to customer behavior, marketing and business decisions etc.

Heroku, AWS and Stripe third party API keys are set up in the application credentials file for security purposes. The file is also encrypted with a master key which is provided to third parties to access those API keys secrets.  

# R17. Describe your projects models in terms of the relationships (active record associations) they have with each other
- A user can have zero to many listings;
- A listing belongs to one and only one user(seller/creator of the listing);
- A user can have zero to many orders;
- An order belong to one and only one user;
- A user can favorite zero to many listings;
- A listing can be favorited by zero to many users;
- A listing belong to a category;
- A category can have zero to many listings;
- An order can have one to many order items;
- An order_item is mapped to a listing;
- An order_item belong to an order;
- An order is mapped to a payment;

# R18. Discuss the database relations to be implemented in your application.

When a user creates a listing, the listing is referred to an “user” by the user_id (foreign key) attribute. This enables the zero-to-many relationship (a user has zero to many listings and a listing belongs to one user) between User & Listing entities. Similarly, when a listing is created, the listing is referred to a “category” by the category_id foreign key attribute. As a result, the zero-to-many relationship between Category & Listing entities is captured. One category can have zero to many listings and a listing has only one category. Because of this relationship design, it is possible to filter the listings by one category or one user. As a result, shop by Category and see “My listings” features are implemented.

When a user adds a listing to an order (aka “add to cart”), a tuple is created in the Orders table. The Orders table contains the user_id foreign key that refers to a user (the buyer who clicked the “add to cart” button/link) in the Users table. As a result, a zero-to-many relationship is established between the User & Order entities. One user can have zero to many orders and an order belongs to one and only one user. 

Right after a line is created in the Orders table, a row is also added in the Items table and this table has 2 foreign key attributes that refer to the Orders (order_id FK) & Listings tables (listing_id FK). The listing_id foreign key attribute must have the “unique” constraint to ensure the one-to-one relationship between the Listing & Item entities. One listing is mapped to one item. On the other hand, the relationship between Order & Item entities is a one-to-many relationship where an order can have one to many items and an item belongs to an order. In the scenario where two or more users add the same listing in their orders, whoever successfully completes their payment session first will get the item. After this, the item status will be changed to sold:true. There is a check to make sure all items are at sold:false status before it can be added to order total and sent to Stripe for payment. 

After a stripe payment checkout session successfully completed, a line will be created in the payments table. This Payment entity is related to the Order entity via a one-to-one relationship where an order_id foreign key attribute is included in the payments table. 

The application relations also include a join table called “favourites” that contains two foreign key attributes namely user_id and listing_id. This table helps establish the many-to-many relationship between the User and Listing entities. A user can have many favourite listings and a listing and be favourited by many users.  

# R19. Provide your database schema design.

![DatabaseSchemaDiagram](docs/KimStocker_DatabaseSchemaDiagram.pdf "DatabaseSchemaDiagram")

# R20. Describe the way tasks are allocated and tracked in your project:

Trello board is used to track the progress of the project. With an Agile approach, a Kanban board with Backlog/User Stories, Design/Research, To do, Doing, Code Review, Testing and Done columns are used to allocate the tasks. Tasks are divided into different major features of the app. Those tasks are then broken down into checklist items. Based on User stories, MVP features are identified and prioritised. Features that are “good to have” are allocated in the Backlog and will be moved up if there is enough time to deliver. Please see Trello screenshots for details. 

![Trello](docs/KimStocker_DatabaseSchemaDiagram.pdf)


# References

- Pandemic game photo: Photo by ibmoon Kim on Unsplash
- Hippo kid game: Photo by Nathan Dumlao on Unsplash
- Ludo: Photo by Folu Eludire on Unsplash
- Catan: Photo by Karthik Balakrishnan on Unsplash
- Dungeon and dragon: Photo by Clint Bustrillos on Unsplash
- Chess: Photo by Jon Tyson on Unsplash
