from types.Binding import Binding

type Parameters {
  sender : Binding
  receiver : Binding
}

service ShoppingList ( params : Parameters ) {
  execution:sequential
  
  embed Console as console
  embed StringUtils as stringUtils
  embed Database as database

  inputPort ShopList {
    location: params.shoplist.location
    protocol: params.shoplist.protocol
    interfaces: SenderInterface   // EDIT
  }
  
  outputPort Computation {
    location: params.computation.location
    protocol: params.computation.protocol
    interfaces: ReceiverInterface   // EDIT
  }

}