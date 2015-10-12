using System.Collections.Generic;

namespace RPC.Service
{

    [RemoteService]
    public class BookService
    {


        /// <summary>
        /// Add a book
        /// </summary>
        /// <param name="aBook"></param>
        /// <returns></returns>
        [RemoteMethod]
        public string AddBook(Book aBook)
        {
            return "Book " + aBook.Name + " added";
        }


        /// <summary>
        /// Save a list of books
        /// </summary>
        /// <param name="books"></param>
        /// <returns></returns>
        [RemoteMethod]
        public IList<Book> SaveBatch(List<Book> books)
        {
            for (var i = 0; i < books.Count; i++)
            {
                books[i].Id = i;
            }

            return books;
        }
    }

    public class Book
    {

        public int Id { get; set; }

        public string Name { get; set; }


    }
}