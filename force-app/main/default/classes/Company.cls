public with sharing class Company {
  public String ceo;
  public String companyName;
  public Integer employeeCount;
  public Long revenue;

  //List of all customers
  private List<Client> customers = new List<Client>();

  //add a customer to the list
  public void addNewCustomer(String clientName, String websiteName, String email, Long phone) {
     //make a new instance of the client class
     Client customer = new Client(clientName,websiteName,email,phone);
    //TODO: add customer
    customers.add(customer);

  }

  //print the list of the customers
  public void getAllCustomers() {
    //TODO print all customers
    for (Client customer : customers){
       System.debug('Customer name: ' + customer.clientName + ', Website: ' + customer.websiteName + ', Email: ' + customer.email +', Phone: ' + customer.phone);
    }
  }

  //private inner class for customer info
  private class Client {
    public String clientName;
    public String websiteName;
    public String email;
    public Long phone;
    //create a constructor class
    Client(String clientName, String websiteName, String email, Long phone){
        //initialize global varaibles based on the parameters
        this.clientName = clientName;
        this.websiteName = websiteName;
        this.email = email;
        this.phone = phone;
    }
  }
}