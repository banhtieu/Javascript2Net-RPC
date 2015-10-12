using System.Collections.Generic;


namespace RPC.Service
{

    public class Bookmark
    {

        /// <summary>
        /// The Id
        /// </summary>
        public int Id { get; set; }

        /// <summary>
        /// the Name
        /// </summary>
        public string Name { get; set; }

        /// <summary>
        /// the URL
        /// </summary>
        public string URL { get; set; }
    }


    [RemoteService]
    public class BookmarkService
    {


        /// <summary>
        /// FInd a bookmark by id
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        [RemoteMethod]
        public Bookmark Find(int id)
        {
            return bookmarks.Find(bookmark => bookmark.Id == id);
        }

        /// <summary>
        /// Save a book mark
        /// </summary>
        /// <param name="bookmark"></param>
        /// <returns></returns>
        [RemoteMethod]
        public bool Save(Bookmark bookmark)
        {
            var existing = Find(bookmark.Id);
            
            if (existing != null)
            {
                var index = bookmarks.IndexOf(existing);
                bookmarks[index] = bookmark;
            }
            else
            {
                bookmark.Id = ++bookmarkId;
                bookmarks.Add(bookmark);
            }

            return true;
        }


        /// <summary>
        /// Get all bookmark
        /// </summary>
        /// <returns></returns>
        [RemoteMethod]
        public IList<Bookmark> GetAll()
        {
            return bookmarks;
        }

        /// <summary>
        /// Delete the item
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        [RemoteMethod]
        public bool Delete(int id)
        {
            var bookmark = Find(id);
            return bookmarks.Remove(bookmark);
        }


        /// <summary>
        /// List of bookmarks
        /// </summary>
        private static List<Bookmark> bookmarks = new List<Bookmark>();

        /// <summary>
        /// Bookmark id
        /// </summary>
        private static int bookmarkId = 0;

    }
}