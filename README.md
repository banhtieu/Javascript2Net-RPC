# Javascript2Net-RPC
An jquery plugin to call asp.net remote methods from javascript

# How to use:
1. Define the service
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
2. Import javascript:
```
 <script src="Scripts/jquery.remote.js"></script>
```
3. Get the remote service:
```
var bookService = $.remoteObject("BookService");
```
4. Use:
```
function buttonClicked() {
    var book = { "Name": "Sample Book" };
    bookService.AddBook(book)
        .then(function (result) {
            alert(result);
        });
}
```
