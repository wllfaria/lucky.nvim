#include <iostream>

#define LK_SAMPLE_DEFINE

#ifdef LK_SAMPLE_DEFINE
#endif

#if TRUE
#elif FALSE
#endif

namespace Lucky {
	class Node {
	public:
		int data;
		struct Node* left;
		struct Node* right;
	};

	static struct Node* create_node(int value) {
		struct Node* node = new Node;
		node->data = value;
		node->left = NULL;
		node->right = NULL;
		return node;
	}

	static void depth_first_search(struct Node* node) {
		if (node == NULL) return;
		depth_first_search(node->left);
		depth_first_search(node->right);
		std::cout << node->data << std::endl;
	}
}

int main() {
	Lucky::Node* node = Lucky::create_node(1);
	node->left = Lucky::create_node(2);
	node->right = Lucky::create_node(3);
	node->left->left = Lucky::create_node(4);
	node->left->right = Lucky::create_node(5);

	Lucky::depth_first_search(node);	

	delete node;
	return 0;
}
