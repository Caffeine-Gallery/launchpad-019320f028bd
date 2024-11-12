import Int "mo:base/Int";
import Nat "mo:base/Nat";

import Time "mo:base/Time";
import Array "mo:base/Array";
import Text "mo:base/Text";
import Buffer "mo:base/Buffer";

actor {
    // Blog post type definition
    type BlogPost = {
        id: Nat;
        title: Text;
        content: Text;
        timestamp: Int;
    };

    // Stable storage for blog posts
    stable var posts : [BlogPost] = [];
    stable var nextId : Nat = 0;

    // Create a new blog post
    public func createPost(title: Text, content: Text) : async BlogPost {
        let post : BlogPost = {
            id = nextId;
            title = title;
            content = content;
            timestamp = Time.now();
        };
        
        let buffer = Buffer.fromArray<BlogPost>(posts);
        buffer.add(post);
        posts := Buffer.toArray(buffer);
        nextId += 1;
        post
    };

    // Get all blog posts
    public query func getPosts() : async [BlogPost] {
        posts
    };

    // Initialize with default content
    public func initializeContent() : async () {
        if (posts.size() == 0) {
            ignore await createPost(
                "How to Launch a New Software Product",
                "1. Market Research\n\nBefore diving into development, thoroughly understand your target market. Identify your potential users, their pain points, and how your software will solve their problems.\n\n2. MVP Development\n\nStart with a Minimum Viable Product (MVP). Focus on core features that address the main problem you're solving. Don't get caught up in perfecting every feature.\n\n3. Beta Testing\n\nConduct thorough beta testing with real users. Their feedback is invaluable for improving your product before the official launch.\n\n4. Marketing Strategy\n\nDevelop a comprehensive marketing strategy. Utilize social media, content marketing, and potentially paid advertising to create buzz around your launch.\n\n5. Launch Preparation\n\nPrepare your support systems, documentation, and onboarding processes. Ensure your infrastructure can handle the expected load.\n\n6. Post-Launch\n\nMonitor user feedback and metrics closely after launch. Be ready to address issues quickly and iterate based on user needs."
            );
        };
    };
}
