<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="RPC.Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Remote Sample</title>

    <script src="Scripts/jquery-2.1.4.min.js"></script>
    <script src="Scripts/jquery.remote.js"></script>
    
    <!-- Compiled and minified CSS -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.97.1/css/materialize.min.css"/>

    <!-- Compiled and minified JavaScript -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.97.1/js/materialize.min.js"></script>

    <link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/highlight.js/8.8.0/styles/default.min.css"/>
    <script src="//cdnjs.cloudflare.com/ajax/libs/highlight.js/8.8.0/highlight.min.js"></script>
    <script>hljs.initHighlightingOnLoad();</script>
    <style>
        pre {
            margin: 0;
            padding: 0;
        }
    </style>
    <script>
        var bookService = $.remoteObject("BookService");

        function buttonClicked() {
            var book = { "Name": "Sample Book" };
            bookService.AddBook(book)
                .then(function (result) {
                    alert(result);
                });
        }

        $(document).ready(function () {
            $('ul.tabs').tabs();
        });
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <nav class="light-blue lighten-1" role="navigation">
            <div class="nav-wrapper container">
                <a id="logo-container" href="#" class="brand-logo">Javascript RPC</a>
                <ul class="right hide-on-med-and-down">
                    <li><a href="https://github.com/banhtieu/Javascript2Net-RPC">Github</a></li>
                </ul>
            </div>
        </nav>

        <div class="section no-pad-bot" id="index-banner">
            <div class="row">
                <div class="col s12 m6">
                    <div class="card">
                        <div class="card-content white-text">
                            <span class="card-title"  style="color: black">C#</span>
                            <pre>
<code class="C#">[RemoteService]
public class BookService
{
    
    // remote service implemented on server side
    [RemoteMethod]
    public string AddBook(Book aBook)
    {
        return "Book " + aBook.Name + " added";
    }
}
</code>
                            </pre>
                        </div>
                    </div>
                </div>
                <div class="col s12 m6">
                    <div class="card">
                        <div class="card-content">
                            <span class="card-title"  style="color: black">Javascript</span>
                            <pre>
<code class="javascript">var bookService = $.remoteObject("BookService");
    
// handle click event
function buttonClicked() {
    
    var book = { "Name": "Sample Book" };
    bookService.AddBook(book)
        .then(function (result) {
            alert(result);
        });
}
</code>
                            </pre>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="row center">
            <a href="javascript: buttonClicked()" id="download-button" class="btn-large waves-effect waves-light orange">Try</a>
        </div>
    </form>
</body>
</html>
