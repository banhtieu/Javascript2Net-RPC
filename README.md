# Javascript2Net-RPC
An jquery plugin to call asp.net remote methods from javascript

# How to use:
## Define the service
```  
[RemoteService]
public class BookService
{
    [RemoteMethod]
    public string AddBook(Book aBook)
    {
        return "Book " + aBook.Name + " added";
    }
```
## Import javascript:
```
 <script src="Scripts/jquery.remote.js"></script>
```
## Get the remote service:
```
var bookService = $.remoteObject("BookService");
```
## Use:
```
function buttonClicked() {
    var book = { "Name": "Sample Book" };
    bookService.AddBook(book)
        .then(function (result) {
            alert(result);
        });
}
```
