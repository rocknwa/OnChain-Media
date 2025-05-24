// SPDX-License-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import {Test, console} from "forge-std/Test.sol";
import {OpenMedia} from "../src/OpenMedia.sol";

// Test contract for OpenMedia smart contract
contract OpenMediaTest is Test {
    OpenMedia public openMedia;
    address public user1 = address(0x1); // Test address for user1
    address public user2 = address(0x2); // Test address for user2
    address public unregisteredUser = address(0x3); // Test address for an unregistered user

    //  Set up the test environment before each test
    function setUp() public {
        openMedia = new OpenMedia(); // Deploy a new instance of OpenMedia
        // Register users for testing
        vm.prank(user1);
        openMedia.createUser("User1", "Bio1"); // Register user1
        vm.prank(user2);
        openMedia.createUser("User2", "Bio2"); // Register user2
    }

    // Test user registration
    // Tests successful creation of a new user
    function test_CreateUser() public {
        address newUser = address(0x4); // New user address
        vm.prank(newUser);
        openMedia.createUser("NewUser", "NewBio"); // Create a new user
        assertEq(openMedia.isUserRegistered(newUser), true); // Verify user is registered
        assertEq(openMedia.getUsername(newUser), "NewUser"); // Verify username is set correctly
    }

    // Tests that creating a user with an existing address reverts
    function test_CreateUserRevertsWhenAlreadyExists() public {
        vm.prank(user1);
        vm.expectRevert("User already exists."); // Expect revert for duplicate user
        openMedia.createUser("User1Again", "BioAgain"); // Attempt to register user1 again
    }

    // Test post creation
    // Tests successful creation of a post by a registered user
    function test_CreatePost() public {
        vm.prank(user1);
        openMedia.createPost("First post"); // Create a post
        assertEq(openMedia.postCount(), 1); // Verify post count incremented
        assertEq(openMedia.getPostAuthorUsername(1), "User1"); // Verify post author
    }

    // Tests that creating a post by an unregistered user reverts
    function test_CreatePostRevertsWhenUserDoesNotExist() public {
        vm.prank(unregisteredUser);
        vm.expectRevert("User does not exist."); // Expect revert for unregistered user
        openMedia.createPost("Invalid post"); // Attempt to create post
    }

    // Test liking a post
    // Tests successful liking of a post by a registered user
    function test_LikePost() public {
        vm.prank(user1);
        openMedia.createPost("Post to like"); // Create a post
        vm.prank(user2);
        openMedia.likePost(1); // User2 likes the post
        assertEq(openMedia.isPostLikedByUser(1, user2), true); // Verify post is liked
    }

    // Tests that liking a post twice by the same user reverts
    function test_LikePostRevertsWhenAlreadyLiked() public {
        vm.prank(user1);
        openMedia.createPost("Post to like"); // Create a post
        vm.prank(user2);
        openMedia.likePost(1); // User2 likes the post
        vm.prank(user2);
        vm.expectRevert("Already liked this post."); // Expect revert for duplicate like
        openMedia.likePost(1); // Attempt to like again
    }

    // Tests that liking a post by an unregistered user reverts
    function test_LikePostRevertsWhenUserDoesNotExist() public {
        vm.prank(user1);
        openMedia.createPost("Post to like"); // Create a post
        vm.prank(unregisteredUser);
        vm.expectRevert("User does not exist."); // Expect revert for unregistered user
        openMedia.likePost(1); // Attempt to like
    }

    // Tests that liking a non-existent post reverts
    function test_LikePostRevertsWhenPostDoesNotExist() public {
        vm.prank(user2);
        vm.expectRevert("Post does not exist."); // Expect revert for non-existent post
        openMedia.likePost(999); // Attempt to like post ID 999
    }

    // Test unliking a post
    // Tests successful unliking of a post by a user who liked it
    function test_UnlikePost() public {
        vm.prank(user1);
        openMedia.createPost("Post to unlike"); // Create a post
        vm.prank(user2);
        openMedia.likePost(1); // User2 likes the post
        vm.prank(user2);
        openMedia.unlikePost(1); // User2 unlikes the post
        assertEq(openMedia.isPostLikedByUser(1, user2), false); // Verify post is not liked
    }

    // Tests that unliking a post that wasn’t liked reverts
    function test_UnlikePostRevertsWhenNotLiked() public {
        vm.prank(user1);
        openMedia.createPost("Post to unlike"); // Create a post
        vm.prank(user2);
        vm.expectRevert("You haven't liked this post."); // Expect revert for unliked post
        openMedia.unlikePost(1); // Attempt to unlike without liking
    }

    // Tests that unliking a post by an unregistered user reverts
    function test_UnlikePostRevertsWhenUserDoesNotExist() public {
        vm.prank(user1);
        openMedia.createPost("Post to unlike"); // Create a post
        vm.prank(unregisteredUser);
        vm.expectRevert("User does not exist."); // Expect revert for unregistered user
        openMedia.unlikePost(1); // Attempt to unlike
    }

    // Tests that unliking a non-existent post reverts
    function test_UnlikePostRevertsWhenPostDoesNotExist() public {
        vm.prank(user2);
        vm.expectRevert("Post does not exist."); // Expect revert for non-existent post
        openMedia.unlikePost(999); // Attempt to unlike post ID 999
    }

    // Test commenting on a post
    // Tests successful commenting on a post by a registered user
    function test_CommentOnPost() public {
        vm.prank(user1);
        openMedia.createPost("Post to comment"); // Create a post
        vm.prank(user2);
        openMedia.commentOnPost(1, "Great post!"); // User2 comments
        assertEq(openMedia.commentCount(), 1); // Verify comment count
        assertEq(openMedia.getCommentsForPost(1).length, 1); // Verify comment array length
        assertEq(openMedia.getCommentsForPost(1)[0].content, "Great post!"); // Verify comment content
        assertEq(openMedia.getCommentsForPost(1)[0].authorUsername, "User2"); // Verify comment author
    }

    // Tests that commenting by an unregistered user reverts
    function test_CommentOnPostRevertsWhenUserDoesNotExist() public {
        vm.prank(user1);
        openMedia.createPost("Post to comment"); // Create a post
        vm.prank(unregisteredUser);
        vm.expectRevert("User does not exist."); // Expect revert for unregistered user
        openMedia.commentOnPost(1, "Invalid comment"); // Attempt to comment
    }

    // Tests that commenting on a non-existent post reverts
    function test_CommentOnPostRevertsWhenPostDoesNotExist() public {
        vm.prank(user2);
        vm.expectRevert("Post does not exist."); // Expect revert for non-existent post
        openMedia.commentOnPost(999, "Invalid comment"); // Attempt to comment on post ID 999
    }

    // Test view functions
    // Tests retrieving the username of a registered user
    function test_GetUsername() public view{
        assertEq(openMedia.getUsername(user1), "User1"); // Verify user1’s username
    }

    // Tests that retrieving the username of an unregistered user reverts
    function test_GetUsernameRevertsWhenUserDoesNotExist() public {
        vm.expectRevert("User does not exist."); // Expect revert for unregistered user
        openMedia.getUsername(unregisteredUser); // Attempt to get username
    }

    // Tests checking registration status of users
    function test_IsUserRegistered() public view{
        assertEq(openMedia.isUserRegistered(user1), true); // Verify user1 is registered
        assertEq(openMedia.isUserRegistered(unregisteredUser), false); // Verify unregistered user is not registered
    }

    // Tests retrieving the username of a post’s author
    function test_GetPostAuthorUsername() public {
        vm.prank(user1);
        openMedia.createPost("Test post"); // Create a post
        assertEq(openMedia.getPostAuthorUsername(1), "User1"); // Verify post author’s username
    }

    // Tests that retrieving the author username for a non-existent post reverts
    function test_GetPostAuthorUsernameRevertsWhenPostDoesNotExist() public {
        vm.expectRevert("Post does not exist."); // Expect revert for non-existent post
        openMedia.getPostAuthorUsername(999); // Attempt to get author for post ID 999
    }

    // Tests retrieving multiple comments for a post
    function test_GetCommentsForPost() public {
        vm.prank(user1);
        openMedia.createPost("Post with comments"); // Create a post
        vm.prank(user2);
        openMedia.commentOnPost(1, "Comment 1"); // Add first comment
        vm.prank(user2);
        openMedia.commentOnPost(1, "Comment 2"); // Add second comment
        assertEq(openMedia.getCommentsForPost(1).length, 2); // Verify two comments retrieved
    }

    // Tests that retrieving comments for a non-existent post reverts
    function test_GetCommentsForPostRevertsWhenPostDoesNotExist() public {
        vm.expectRevert("Post does not exist."); // Expect revert for non-existent post
        openMedia.getCommentsForPost(999); // Attempt to get comments for post ID 999
    }

    // Tests that checking like status for a non-existent post reverts
    function test_IsPostLikedByUserRevertsWhenPostDoesNotExist() public {
        vm.expectRevert("Post does not exist."); // Expect revert for non-existent post
        openMedia.isPostLikedByUser(999, user2); // Attempt to check like status for post ID 999
    }

    // Fuzz tests
    // Tests user creation with random usernames and bios
    function testFuzz_CreateUser(string memory username, string memory bio) public {
        vm.assume(bytes(username).length > 0); // Ensure username is not empty
        address newUser = address(0x5); // New user address
        vm.prank(newUser);
        openMedia.createUser(username, bio); // Create user with random inputs
        assertEq(openMedia.isUserRegistered(newUser), true); // Verify user is registered
        assertEq(openMedia.getUsername(newUser), username); // Verify username is set
    }

    // Tests post creation with random content
    function testFuzz_CreatePost(string memory content) public {
        vm.prank(user1);
        openMedia.createPost(content); // Create post with random content
        assertEq(openMedia.postCount(), 1); // Verify post count
        (,, string memory postContent,) = openMedia.posts(1); // Get post content
        assertEq(postContent, content); // Verify content matches
    }

    // Tests commenting with random comment content
    function testFuzz_CommentOnPost(string memory comment) public {
        vm.prank(user1);
        openMedia.createPost("Fuzz post"); // Create a post
        vm.prank(user2);
        openMedia.commentOnPost(1, comment); // Comment with random content
        assertEq(openMedia.getCommentsForPost(1)[0].content, comment); // Verify comment content
    }
}
