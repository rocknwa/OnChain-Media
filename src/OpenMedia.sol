// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract OpenMedia {
    // Struct to represent a user
    struct User {
        address userAddress;
        string username;
        string bio;
    }

    // Struct to represent a post
    struct Post {
        uint256 postId;
        address author;
        string content;
        uint256 likes;
        mapping(address => bool) likedBy; // Mapping to track which users have liked the post
        uint256[] commentIds; // Array to store comment IDs associated with the post
    }

    // Struct to represent a comment
    struct Comment {
        uint256 commentId;
        string authorUsername; // Store the username of the commenter
        uint256 postId;
        string content;
    }

    // Mappings to store users, posts, and comments
    mapping(address => User) public users;
    mapping(uint256 => Post) public posts;
    mapping(uint256 => Comment) public comments;

    // Counters for posts and comments
    uint256 public postCount;
    uint256 public commentCount;

    // User Registration
    function createUser(string memory _username, string memory _bio) public {
        require(bytes(users[msg.sender].username).length == 0, "User already exists.");
        users[msg.sender] = User(msg.sender, _username, _bio);
    }

    // Function to get the username from an account address
    function getUsername(address _userAddress) public view returns (string memory) {
        require(bytes(users[_userAddress].username).length != 0, "User does not exist.");
        return users[_userAddress].username;
    }

    // Creating a post
    function createPost(string memory _content) public {
        require(bytes(users[msg.sender].username).length != 0, "User does not exist.");
        postCount++;
        Post storage newPost = posts[postCount];
        newPost.postId = postCount;
        newPost.author = msg.sender;
        newPost.content = _content;
        newPost.likes = 0;
    }

    // Liking a post
    function likePost(uint256 _postId) public {
        require(bytes(users[msg.sender].username).length != 0, "User does not exist.");
        require(posts[_postId].author != address(0), "Post does not exist.");
        require(!posts[_postId].likedBy[msg.sender], "Already liked this post.");
        posts[_postId].likes++;
        posts[_postId].likedBy[msg.sender] = true;
    }

    // Unliking a post
    function unlikePost(uint256 _postId) public {
        require(bytes(users[msg.sender].username).length != 0, "User does not exist.");
        require(posts[_postId].author != address(0), "Post does not exist.");
        require(posts[_postId].likedBy[msg.sender], "You haven't liked this post.");
        posts[_postId].likes--;
        posts[_postId].likedBy[msg.sender] = false;
    }

    // Commenting on a post
    function commentOnPost(uint256 _postId, string memory _content) public {
        require(bytes(users[msg.sender].username).length != 0, "User does not exist.");
        require(posts[_postId].author != address(0), "Post does not exist.");
        commentCount++;
        Comment storage newComment = comments[commentCount];
        newComment.commentId = commentCount;
        newComment.authorUsername = users[msg.sender].username; // Store the username of the commenter
        newComment.postId = _postId;
        newComment.content = _content;

        // Add comment ID to the post's commentIds array
        posts[_postId].commentIds.push(commentCount);
    }

    // Check if a post is liked by a user
    function isPostLikedByUser(uint256 _postId, address _user) public view returns (bool) {
        require(posts[_postId].author != address(0), "Post does not exist.");
        return posts[_postId].likedBy[_user];
    }

    // Check if a user is registered
    function isUserRegistered(address _user) public view returns (bool) {
        return bytes(users[_user].username).length != 0;
    }

    // Get the username of the post author
    function getPostAuthorUsername(uint256 _postId) public view returns (string memory) {
        require(posts[_postId].author != address(0), "Post does not exist.");
        address authorAddress = posts[_postId].author;
        return users[authorAddress].username;
    }

    // Get all comments for a post
    function getCommentsForPost(uint256 _postId) public view returns (Comment[] memory) {
        require(posts[_postId].author != address(0), "Post does not exist.");
        uint256 commentCountForPost = posts[_postId].commentIds.length;
        Comment[] memory postComments = new Comment[](commentCountForPost);

        for (uint256 i = 0; i < commentCountForPost; i++) {
            postComments[i] = comments[posts[_postId].commentIds[i]];
        }

        return postComments;
    }
}