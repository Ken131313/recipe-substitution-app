-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Mar 18, 2025 at 01:22 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `cbook`
--

-- --------------------------------------------------------

--
-- Table structure for table `cache`
--

CREATE TABLE `cache` (
  `key` varchar(255) NOT NULL,
  `value` mediumtext NOT NULL,
  `expiration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cache_locks`
--

CREATE TABLE `cache_locks` (
  `key` varchar(255) NOT NULL,
  `owner` varchar(255) NOT NULL,
  `expiration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `comments`
--

CREATE TABLE `comments` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `recipe_id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `body` text NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `comments`
--

INSERT INTO `comments` (`id`, `recipe_id`, `user_id`, `body`, `created_at`, `updated_at`) VALUES
(3, 12, 2, 'clear instructions!', '2025-03-10 18:53:26', '2025-03-10 18:53:26'),
(4, 16, 8, 'PURE GUIDELINE!!!', '2025-03-11 22:17:02', '2025-03-11 22:17:02'),
(5, 18, 2, 'Suggest that we all add sugar if you use tomato paste + water. Or else it would be too sour', '2025-03-13 00:46:57', '2025-03-13 00:46:57'),
(6, 11, 10, 'Great recipe', '2025-03-17 22:06:53', '2025-03-17 22:06:53');

-- --------------------------------------------------------

--
-- Table structure for table `ingredients`
--

CREATE TABLE `ingredients` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `category` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ingredient_substitutions`
--

CREATE TABLE `ingredient_substitutions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `ingredient_id` bigint(20) UNSIGNED NOT NULL,
  `substitute_ingredient_id` bigint(20) UNSIGNED NOT NULL,
  `edge_weight` double NOT NULL,
  `criteria` text NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2024_12_08_022052_create_users_table', 1),
(2, '2024_12_08_022230_create_recipe_table', 1),
(3, '2024_12_08_022302_create_ingredients_table', 1),
(4, '2024_12_08_022443_create_recipe_ingredients_table', 1),
(5, '2024_12_08_022504_create_ingredients_substitutions_table', 1),
(6, '2024_12_08_222316_create_sessions_table', 1),
(7, '2025_01_27_205046_add_image_and_ingredients_to_recipes_table', 1),
(8, '2025_01_28_211254_add_steps_to_recipes_table', 1),
(9, '2025_01_28_215741_create_substitutions_table', 1),
(10, '2025_01_31_215133_create_cache_table', 1),
(11, '2025_02_08_140058_add_collections_to_recipes_table', 1),
(12, '2025_02_09_235249_create_comments_table', 1),
(13, '2025_02_10_005125_update_comments_table_add_missing_columns', 1),
(14, '2025_03_05_225650_add_user_preferences_to_users_table', 2),
(15, '2025_03_06_151219_add_allergies_to_recipes_table', 3),
(16, '2025_03_16_231710_create_saved_recipes_table', 4);

-- --------------------------------------------------------

--
-- Table structure for table `recipes`
--

CREATE TABLE `recipes` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `created_by` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `ingredients` text DEFAULT NULL,
  `steps` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`steps`)),
  `collections` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`collections`)),
  `slug` varchar(255) DEFAULT NULL,
  `allergies` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `recipes`
--

INSERT INTO `recipes` (`id`, `title`, `description`, `created_by`, `created_at`, `updated_at`, `image`, `ingredients`, `steps`, `collections`, `slug`, `allergies`) VALUES
(5, 'Clam and tofu soup', 'chinese people love soup. unlike western style soups, they prefer theirs to be clean and light in taste…. definitely no cream or butter, or any dairy product for that matter. a very simple yet common soup is tofu with cilantro in a chicken broth. usually a century egg is thrown in there for protein, though it doesn’t add much to the flavor. so instead of the dark fermented egg, we substituted it with clams! this is a tasty broth that cooks in less than 10 minutes.', 2, '2025-02-25 00:11:41', '2025-02-25 00:11:41', 'recipe_images/UCAyNtTIyetPstiIvfC1RNiH72bPFUdojdb443mC.jpg', '\"[\\\"Clam\\\",\\\"Tofu\\\",\\\"Ginger\\\",\\\"Cookwine\\\",\\\"Bok choy\\\",\\\"Salt\\\",\\\"water\\\"]\"', '\"[\\\"wash the clams and soak them in cold water for at least 15 minutes\\\",\\\"add oil to a pot and turn heat on high. toss in the garlic, shallot, and ginger to lightly brown\\\",\\\"throw in the clams and stir for a minute\\\",\\\"add the white wine and chicken stock, bring to a boil\\\",\\\"throw in the cilantro, green onion, and tofu\\\",\\\"turn down heat to simmer\\\",\\\"clams are cooked when they open\\\"]\"', '[\"High in Protein\",\"Seafood\"]', 'clam-and-tofu-soup', NULL),
(6, 'Bok choy stir fry', 'This basic bok choy stir-fry is a staple in our house. We\'ve included instructions for any variety—it\'s easy to make, healthy, and goes with everything!', 2, '2025-02-25 00:22:33', '2025-02-25 00:22:33', 'recipe_images/NLMb1KKjIt3JKmsQbN9gwOBwK0FfhC7N2tDAB0Va.jpg', '\"[\\\"Bok choy\\\",\\\"Oil\\\",\\\"Garlic\\\",\\\"Ginger\\\",\\\"Salt\\\",\\\"Seasame oil\\\",\\\"MSG\\\",\\\"Cornstarch\\\",\\\"White pepper\\\"]\"', '\"{\\\"0\\\":\\\"If using smaller bok choy, cut them into halves lengthwise. Any pieces that look a bit too big can be cut into quarters. This will make them easier to eat and help loosen sand and dirt during washing.\\\",\\\"1\\\":\\\"If using medium or large bok choy, separate the bulbs into individual stems. Trim away the tough base. If they\\\\u2019re very large, cut the bok choy at a slight angle into 1-inch pieces. Note that it\\\\u2019s easier to wash large bok choy leaves\\\\\\/stems before cutting.\\\",\\\"2\\\":\\\"Throw the bok choy into a large bowl with lots of cold water. Agitate the veggies with your hands and\\\\\\/or use your faucet sprayer to loosen any dirt. Soak for 5 to 10 minutes (you can leave them for longer if you are prepping other things).\\\",\\\"3\\\":\\\"Scoop the veggies out of the water into a colander, and rinse the bowl clean of any sand. Repeat the process until you don\\\\u2019t see any dirt on the leaves or at the bottom of your bowl\\\\u2014usually 2 more times will do the trick. On the second or third soak, you can run your fingers on the stems to loosen any stubborn sand.\\\",\\\"5\\\":\\\"After the final wash, give your colander of bok choy a few good shakes to release any excess water.\\\",\\\"6\\\":\\\"Cooking the Bok Choy:\\\",\\\"7\\\":\\\"Heat your wok or a large pan over low heat, and add the oil and ginger. If you prefer a stronger garlicky flavor, add the garlic now. You can let it sizzle in the oil for 10-15 seconds, but don\\\\u2019t let it brown, or it will turn bitter. Add the veggies when the garlic is still white. If you like a fresher, more mild garlic flavor, add it in after salting the vegetables.\\\",\\\"8\\\":\\\"Add the veggies, and increase the heat to high. Stir-fry using a scooping motion so the oil and aromatics are evenly distributed.\\\",\\\"9\\\":\\\"Next, add salt, sesame oil (if using), the MSG (if using), and the white pepper. Stir-fry for another 1-2 minutes. Finish off with the cornstarch slurry, adding it to the center of the vegetables. Toss the vegetables until they are glistening. Plate and serve immediately.\\\"}\"', '[\"Vegan\",\"Gluten Free\"]', 'bok-choy-stir-fry', NULL),
(7, 'Coconut Curry Shrimp', 'This simple coconut curry shrimp with a red curry sauce will have you enjoying a restaurant experience at home on any day of the week.', 7, '2025-03-06 21:07:17', '2025-03-06 21:07:17', 'recipe_images/ToCv5fYCbEQFikrcIF7Oc4NUgi7K1OatyP3Fb8CV.jpg', '\"[\\\"Oil\\\",\\\"Shrimp\\\",\\\"Garlic\\\",\\\"Red bell pepper\\\",\\\"Full-fat coconut milk\\\",\\\"Red bell pepper\\\",\\\"Brown sugar\\\",\\\"Thai red curry paste\\\"]\"', '\"[\\\"Heat a wok or large skillet over medium-high heat until. Add 1 tablespoon of oil, and spread it around to coat. Add the shrimp, and allow it to sear for 30 seconds on 1 side. Then stir-fry for 30 seconds, until the shrimp is 75% cooked (it should be mostly opaque). Turn off the heat, remove the shrimp to a bowl, and set aside.\\\",\\\"Over medium heat, add the remaining tablespoon of oil to the pan, along with the garlic and ginger. Fry for 30 seconds, until fragrant. Increase the heat to medium-high, add the curry paste, and fry for another minute. Stir in the brown sugar. Then add the onion and pepper, and fry for 2 minutes.\\\",\\\"Add the coconut milk. Bring to a simmer over medium-high heat. (From this point on, keep the curry at a simmer. Avoid boiling it too vigorously, or the coconut milk may split and have a grainy appearance.) Simmer for 2 minutes to thicken the sauce and cook the onions down.\\\",\\\"Stir in the shrimp, and simmer for 1 more minute. Taste and season with additional salt if needed (particularly if you used less curry paste). Garnish with cilantro if desired, and serve!\\\"]\"', '[\"High in Protein\",\"Seafood\"]', 'coconut-curry-shrimp', NULL),
(8, 'Stuffed Bitter Melon', 'This stuffed bitter melon recipe in black bean sauce is a classic Cantonese dish that beautifully showcases bitter melon.', 7, '2025-03-06 22:22:53', '2025-03-06 22:22:53', 'recipe_images/e1sTHh9bX8BWT2pCbHKYcUJZRLtATaa6fP7bYvEx.jpg', '\"[\\\"Dried shiitake mushrooms\\\",\\\"Ground pork\\\",\\\"Dark soy sauce\\\",\\\"Sesame oil\\\",\\\"Shaoxing wine\\\",\\\"Oil\\\",\\\"Salt\\\",\\\"Garlic\\\",\\\"Ginger\\\",\\\"Chinese bitter melon\\\",\\\"Whole fermented black beans\\\",\\\"Sugar\\\",\\\"Chicken stock\\\",\\\"Light Soy sauce\\\"]\"', '\"[\\\"If soaking shiitake mushrooms overnight, you can start in cold water. Place a small bowl or plate on top of the mushrooms to keep them submerged. To soak them faster, start with hot water, and soak for 2 hours until reconstituted. Squeeze any excess moisture off the of the mushrooms, trim away the stems if they\\\\u2019re touch, and finely chop them. You should have about 1\\\\\\/3 cup.\\\",\\\"Add the mushrooms and ground pork to the bowl of a stand mixer fitted with a paddle attachment or a mixing bowl. Add the cornstarch, oyster sauce, Shaoxing wine, sugar, sesame oil, salt, and white pepper. Turn the mixer on low speed for 3 minutes, or mix with a pair of chopsticks vigorously for 5 minutes, until the mixture starts to have a paste-like consistency.\\\",\\\"Bring 8 cups of water to a boil with 1 tablespoon baking soda. Slice the bitter melon into rings about 3\\\\\\/4 inch thick. Scoop out the centers of the bitter melon with a small spoon or paring knife. I like to cut the middle out with the paring knife and then scrape the remaining pith with a spoon. Blanch the bitter melon rings in the water for 1 minute, and then transfer to an ice bath.\\\",\\\"Add 1 1\\\\\\/2 tablespoons cornstarch to a shallow dish. Sprinkle a little cornstarch on the inside of each bitter melon ring, which will help the filling stick to the inside. Use a butter knife to fill the bitter melon rings with the filling, flattening the filling so it\\\\u2019s flush with the melon slice and the meat overlaps slightly with the outer ring of the bitter melon (this will keep the filling from falling out).\\\",\\\"Heat a wok or or cast iron pan over medium-high heat until lightly smoking (or heat a non-stick pan over medium-high heat). Add 2 tablespoons of neutral oil. Add the bitter melon pieces, and fry until golden on each side, about 2-3 minutes per side. Remove from the pan and set aside.\\\",\\\"To the oil left in the wok, add the ginger, garlic, and fermented black beans. Cook for 30 seconds, and then add the Shaoxing wine. Cook for another 30 seconds, and then add the stock, oyster sauce, sugar, light soy sauce, and dark soy sauce. Bring to a simmer. Once simmering, add the bitter melon pieces back to the wok, cover, and simmer for 4-5 minutes to cook the meat through (cook for 5 minutes if you like your bitter melon more tender). Mix the remaining 1 tablespoon cornstarch into a slurry with 1 tablespoon water, and add to the simmering sauce to thicken. Simmer until the sauce is glossy and coats the bitter melon pieces.\\\",\\\"Plate the bitter melon and pour the sauce over the top. Serve!\\\"]\"', '[\"Vegan\",\"High in Protein\",\"Meat\"]', 'stuffed-bitter-melon', NULL),
(10, 'Cantonese Shrimp and Eggs', 'Cantonese Shrimp and Eggs is a classic recipe transforming scrambled eggs into an epic dinner. Plus, the Chinese trick to really silky eggs!', 2, '2025-03-10 18:38:05', '2025-03-10 18:38:05', 'recipe_images/6wuZ16niHX96eg8S4e6nbsJbFWEVzdA6H5yLY0eC.jpg', '\"[\\\"Shrimp\\\",\\\"Eggs\\\",\\\"Soy sauce\\\",\\\"Sesame oil\\\",\\\"Scallions\\\",\\\"Cornstarch\\\"]\"', '\"[\\\"Add the peeled, deveined shrimp to a medium bowl, along with the oil, sugar, salt, white pepper, and cornstarch. Mix until well combined.\\\",\\\"Crack the eggs into a large bowl, and add the white pepper, sesame oil, and salt. Prepare the cornstarch slurry. You\\\\u2019ll add it right before you\\\\u2019re ready to cook the eggs. Beat the eggs until large bubbles form\\\\u2014about 30 seconds, maybe a little longer if you\\\\u2019re not so confident beating eggs.\\\",\\\"Preheat your wok over medium heat until it\\\\u2019s just starting to smoke. Add 1 tablespoon of oil around the perimeter. Spread the shrimp in one layer, and cook until they\\\\u2019ve juuust turned orange. They should still look a bit raw in the center. Transfer back to the marinating bowl. They will finish cooking later.\\\",\\\"Stir up your cornstarch slurry to make sure the cornstarch is dispersed in the water, and add it to the eggs. Beat a few times to make sure the cornstarch is incorporated and the eggs are aerated. Increase the heat to high.\\\",\\\"When the wok begins to smoke again, add the remaining 3 tablespoons of oil, followed by the eggs. They will immediately puff up and cook. Quickly use your wok spatula to gently push the eggs across the wok. Do this a few times.\\\",\\\"When the eggs are beginning to set but still mostly runny, add the shrimp. As you push the eggs around, layers of egg will cook and pile on top of each other, creating a fluffy effect, and the shrimp will get distributed throughout the eggs. As the egg cooks, you can fold it on top of itself.\\\",\\\"When the eggs are still a bit wobbly looking, but mostly cooked, sprinkle the scallions over the top. Give one or two final stirs to combine, then transfer to a serving plate. The dish will continue to cook in the minutes before you eat!\\\"]\"', '[\"Vegan\",\"Gluten Free\",\"High in Protein\",\"Seafood\"]', 'cantonese-shrimp-and-eggs', NULL),
(11, 'Plant-Based Sweet & Sour Stir-fry chicken/tofu', 'This sweet and sour chicken stir-fry recipe is a version of the Asian-style favorite that includes carrots, bell pepper, garlic, and pineapple. The requisite soy sauce and vinegar add the sour to the sweet!', 2, '2025-03-10 18:43:53', '2025-03-10 18:43:53', 'recipe_images/WNIMBcU8wTP6c84sBR2cMs87nce94m0fXEm53Fbi.jpg', '\"[\\\"Soy sauce\\\",\\\"Vegetable oil\\\",\\\"Chicken\\\",\\\"Sugar\\\"]\"', '\"[\\\"Squeeze all excess water out of the tofu, chop the tofu into bite-size pieces then coat with corn starch.\\\",\\\"Meanwhile, chop the yellow onion, bell peppers and pineapples into chunks.\\\",\\\"Add some oil to the pan, and fry the tofu until all sides are golden. Move to a plate then set aside.\\\",\\\"Combine all the sauce ingredients and mix well.\\\",\\\"Back to the pan, add the diced yellow onions and stir fry for 1-2 minutes until transparent. Add in the diced bell peppers and pineapple chunks. Stir fry for 5 minutes until the veggies become tender but still crunchy.\\\",\\\"Add in the sauce and simmer until thickened. Add back in the fried tofu cubes, and mix everything together.\\\",\\\"Add scallions and stir fry for another 5 minutes until everything is well incorporated.\\\",\\\"Garnish the dish with roasted sesame seeds and enjoy with a bowl of warm rice or noodles.\\\"]\"', '[\"Vegan\",\"High in Protein\",\"Meat\"]', 'plant-based-sweet-sour-stir-fry-chickentofu', NULL),
(12, 'Kung Pao Shrimp', 'This Kung Pao Shrimp is a symphony of flavors, accentuated by the crunch of peanuts and the spice of Sichuan peppercorns and dried red chilies. It’s delicious with rice, and disappeared fast when we cooked and photographed it! A telltale sign of a winning recipe.', 2, '2025-03-10 18:52:59', '2025-03-10 18:52:59', 'recipe_images/Msw12GIFqsRiPgER9BL3nlRZog4GzwEl5XoOBU3n.jpg', '\"[\\\"Shrimp\\\",\\\"Shaoxing wine\\\",\\\"Light Soy sauce\\\",\\\"Dark soy sauce\\\",\\\"Scallions\\\",\\\"Oil\\\",\\\"Garlic\\\",\\\"Ginger\\\",\\\"Rice wine vinegar\\\",\\\"Dried red chilies\\\",\\\"Cornstarch\\\"]\"', '\"{\\\"0\\\":\\\"Roast the peanuts:\\\",\\\"2\\\":\\\"Heat 1 teaspoon of oil in a wok over medium heat. Add the peanuts. Stir constantly (or they\\\\u2019ll burn) for 4-5 minutes. Turn off the heat, and stir for another minute using the residual heat of the wok. Set aside to cool.\\\",\\\"3\\\":\\\"They will turn crunchy once completely cooled. You can also skip this step and use already roasted, shelled unsalted peanuts.\\\",\\\"4\\\":\\\"Prepare the shrimp:\\\",\\\"5\\\":\\\"Butterfly each shrimp, making a small cut along its back without cutting it all the way through. Add the shrimp to a bowl, along with the oil, Shaoxing wine, salt, and white pepper powder. Set aside for 15 minutes.\\\",\\\"6\\\":\\\"Mix in the cornstarch right before cooking.\\\",\\\"7\\\":\\\"Prepare the sauce:\\\",\\\"8\\\":\\\"In a medium bowl, make the sauce by combining the water, rice wine vinegar, light soy sauce, sugar, cornstarch, Sichuan peppercorn powder, and dark soy sauce.\\\",\\\"9\\\":\\\"Assemble the dish:\\\",\\\"10\\\":\\\"Heat the wok over high heat, until it just starts to smoke. Add 2 tablespoons of oil, followed by the shrimp (be sure to stir the \\\\u00bd teaspoon cornstarch into the shrimp before searing). Quickly sear the shrimp on both sides, and transfer to a bowl once they turn light pink. Set aside.\\\",\\\"11\\\":\\\"Reduce the heat to low. Add the remaining tablespoon of oil, garlic, ginger, chilies, and scallions. Cook for 1-2 minutes, until fragrant, maintaining low heat.\\\",\\\"12\\\":\\\"Increase the heat to high, and add the shrimp back to the wok. Stir-fry for 30 seconds. Stir up your prepared sauce (the cornstarch settles to the bottom and should be re-stirred). Add the sauce to the wok, and stir-fry for another minute. The sauce should thicken very quickly. Add the peanuts, and turn off the heat. Mix everything well, and serve!\\\"}\"', '[\"Gluten Free\",\"High in Protein\",\"Seafood\"]', 'kung-pao-shrimp', NULL),
(13, 'Cashew Chicken/Tofu', 'The soft, creamy crunch of cashews is a perfect addition to this saucy chicken stir fry! Truly stacks up to your favourite take out', 2, '2025-03-11 19:57:34', '2025-03-11 19:57:34', 'recipe_images/0a1pgWOCt2DBGbIPvisGJsm5Q49vA9FWtQPeQXQ5.jpg', '\"[\\\"Cornstarch\\\",\\\"Soy sauce\\\",\\\"Chinese cooking wine\\\",\\\"Oyster sauce\\\",\\\"Sesame oil\\\",\\\"White pepper\\\",\\\"Chicken thigh, skinless boneless\\\",\\\"Peanut oil\\\",\\\"Garlic cloves , minced\\\",\\\"Onion\\\",\\\"Capsicum\\\",\\\"Water\\\",\\\"Cashew\\\"]\"', '\"[\\\"Sauce: Mix cornflour and soy sauce until there\\\\u2019s no lumps. Then add remaining Sauce ingredients and mix.\\\",\\\"Marinate: Transfer 2 tbsp Sauce to chicken, mix to coat. Set aside for 10 minutes+.\\\",\\\"Cook: Heat oil over high heat in a wok or heavy based skillet. Add the garlic and onion, cook for 1 minute.\\\",\\\"Add chicken and cook for 2 minutes. Add capsicum and cook for 1 minute.\\\",\\\"Add Sauce and water. Bring to simmer and cook, stirring, for 1 minute or until Sauce thickens.\\\",\\\"Stir through cashews, remove from stove. Serve immediately with rice\\\"]\"', '[]', 'cashew-chickentofu', NULL),
(14, 'Steamed Chicken with Black Bean Sauce', 'Chinese steamed chicken with black bean sauce is a comforting home-cooked Cantonese recipe that’s super simple, yet flavorful!', 2, '2025-03-11 21:51:52', '2025-03-11 21:51:52', 'recipe_images/1gRWcywpSYdxVZJRbVimFRbgLfAzUxQ1EulfXucK.jpg', '\"[\\\"Boneless skinless chicken thighs\\\",\\\"Shaoxing wine\\\",\\\"Soy sauce\\\",\\\"Sesame oil\\\",\\\"Scallions\\\",\\\"Oil\\\",\\\"Oyster sauce\\\",\\\"Salt\\\",\\\"Garlic\\\",\\\"Chinese fermented black beans\\\",\\\"Sugar\\\",\\\"Cornstarch\\\"]\"', '\"[\\\"In a medium bowl, marinate the chicken pieces with the Shaoxing wine, light soy sauce, neutral oil, oyster sauce, sugar, sesame oil, salt, and white pepper. Mix well, until the chicken is evenly coated in marinade. Cover the bowl with an overturned plate and marinate in the fridge for at least 2 hours, or overnight.\\\",\\\"1 hour before cooking, take the chicken out of the fridge and let it come up to room temperature. Prepare the garlic, scallions, and black beans.\\\",\\\"Just before cooking, add the garlic, black beans, water (I used 2 tablespoons, but you can add up to 4 tablespoons if you like more sauce), and cornstarch. Mix well, and transfer the chicken to a heatproof dish large enough to keep the chicken in a single layer while still being able to fit into your steamer, with some depth to hold any sauce\\\\\\/juices. A glass or ceramic pie plate works well.\\\",\\\"Bring the water in your steamer to boil over high heat, making sure the water level is at least a couple inches, but won\\\\u2019t touch the bottom of the dish when boiling. Cover and steam the chicken over high heat for 10 minutes. (Steam for 9 minutes if using chicken breast.)\\\",\\\"Turn off the heat, but keep the lid tightly covered. Let the chicken sit in the steamer for an additional 2 minutes before removing the lid. Use a clean dry kitchen towel or plate lifter to carefully remove the dish from the steamer. Garnish with chopped scallion, and serve immediately with rice and your favorite vegetable side!\\\"]\"', '[\"High in Protein\",\"Meat\"]', 'steamed-chicken-with-black-bean-sauce', NULL),
(15, 'Beef with Bamboo Shoots & Peppers', 'This Chinese stir-fry of beef with bamboo shoots & peppers is savory, tasty, and quick to make—perfect with steamed rice or rice porridge!', 8, '2025-03-11 22:08:20', '2025-03-11 22:08:20', 'recipe_images/TlI87cEoErrPLm0BwynHnOUzozY25n8N0MKELnb6.jpg', '\"[\\\"12 ounces beef flank steak\\\",\\\"2 tablespoons water\\\",\\\"2 teaspoons cornstarch\\\",\\\"2 teaspoons neutral oil\\\",\\\"1 teaspoon oyster sauce\\\",\\\"1 teaspoon light soy sauce\\\",\\\"2 tablespoons neutral oil\\\",\\\"3 cloves garlic (sliced)\\\",\\\"6 long hot green peppers (or Anaheim or Cubanelle peppers, seeded and julienned into 3-inch\\\\\\/7-8cm strips)\\\",\\\"1 tablespoon Shaoxing wine\\\",\\\"5 ounces canned julienned bamboo shoots (you get 5 ounces\\\\\\/140g drained from an 8-ounce\\\\\\/225g can)\\\",\\\"1\\\\\\/4 teaspoon salt\\\",\\\"1\\\\\\/2 teaspoon sugar\\\",\\\"2 teaspoons light soy sauce\\\",\\\"2 teaspoons dark soy sauce\\\"]\"', '\"[\\\"Thinly slice the flank steak against the grain, and then cut those slices lengthwise into thin strips. (This is easier to do when the meat is partially frozen.)\\\",\\\"In a medium bowl, add the strips of flank steak, water, cornstarch, oil, oyster sauce, and light soy sauce. Set aside for 20 minutes to marinate at room temperature.\\\",\\\"Place your wok over high heat until it\\\\u2019s almost smoking. Add 1 tablespoon of oil and tilt the wok to spread it evenly around its perimeter. Add the beef in 1 layer, and let it sear for 30 to 40 seconds without moving, then stir- fry for another 30 to 40 seconds, until the beef is browned but still a bit rare. Remove the beef from the wok and set aside.\\\",\\\"Let the empty wok heat again over high heat, and add the remaining tablespoon of oil, along with the garlic and peppers. Stir-fry for 20 seconds, then add the Shaoxing wine to deglaze the wok. After another 20 seconds, add the bamboo shoots.\\\",\\\"Add the beef back to the wok, along with any residual beef juices. Add the salt, sugar, light soy sauce, and dark soy sauce. Increase the heat to high, and stir-fry for another minute. Serve with steamed rice.\\\"]\"', '[\"Meat\"]', 'beef-with-bamboo-shoots-peppers', NULL),
(16, 'Gluten-free Dumplings', 'These gluten-free dumplings pan-fry well, boil well, and can also be steamed. Most importantly, you can also freeze any uncooked dumplings for later!', 8, '2025-03-11 22:16:31', '2025-03-11 22:16:31', 'recipe_images/30ZmEIP02605rn8LzL5T1mUDkPBoCHSzC3jPPFHk.jpg', '\"[\\\"Gluten-free flour (King Arthur)\\\",\\\"Tapioca starch\\\",\\\"Glutinous rice flour\\\",\\\"Xanthan gum in gluten free\\\",\\\"Mince pork (20% fat)\\\"]\"', '\"{\\\"0\\\":\\\"Prepare the dough:\\\",\\\"2\\\":\\\"In a large bowl, whisk together the gluten-free flour, tapioca starch, glutinous rice flour, and xanthan gum.\\\",\\\"3\\\":\\\"Sprinkle the water evenly over the dry ingredients, and mix with a rubber spatula until the dough comes together. Knead with your hands until the dough is smooth.\\\",\\\"4\\\":\\\"Cut the dough into four pieces. Take one piece out, keeping everything else in the bowl and tightly covered with plastic wrap. Roll the dough into a 6-inch log. Cut each log in half and then into thirds so you have 6 pieces. (The dough ball should measure about 420g, which means that each of your wrappers should weigh about 20g before rolling out.) Keep the spare pieces in the bowl under the plastic wrap while you roll out each dumpling wrapper.\\\",\\\"5\\\":\\\"Assemble the dumplings:\\\",\\\"7\\\":\\\"Take out a bamboo or wooden cutting board as your work surface, as well as a rolling pin (a Chinese rolling pin is best). If your dough is sticking to the work surface or rolling pin, lightly dust them with tapioca starch or cornstarch.\\\",\\\"8\\\":\\\"Roll each piece of dough into a circle about 4 inches\\\\\\/10cm or so in diameter and \\\\u215b-inch\\\\\\/3mm thick. Have a small bowl of water nearby to moisten the outer edges of the circle, then add a heaping tablespoon of dumpling filling to the center. Pleat the dumpling closed (see our post on how to fold dumplings, 4 ways, from easiest to hardest!) Place on a tray lined with parchment paper. Keep the dumplings covered with plastic wrap as you shape them. Repeat until you\\\\u2019ve assembled all the dumplings.\\\",\\\"9\\\":\\\"It is best to roll each wrapper out just before assembling the dumpling. Once you have filled a tray, transfer the dumplings immediately to the freezer (covered with plastic), or cook the dumplings fresh!\\\",\\\"10\\\":\\\"Cook the dumplings:\\\",\\\"12\\\":\\\"If boiling, bring a pot of water to a rolling boil, and then stir the water with a spoon to create a whirlpool effect. While the water is swirling, drop the dumplings in (swirling the water around while adding the dumplings prevents them from sinking and sticking to the bottom of the pot). Cook until the dumplings float and the wrappers are cooked through but still al dente\\\\u2014about 7 minutes for fresh dumplings, or 8 minutes for frozen. Serve.\\\",\\\"14\\\":\\\"If pan-frying, heat a nonstick pan over medium-high heat. Add a couple tablespoons of oil, placing the dumplings in the pan slightly apart so they\\\\u2019re not touching. Brown the bottoms, then add about \\\\u00bd cup\\\\\\/120ml of water (you need just a thin layer of water). Cover immediately, reduce the heat to medium-low, and cook until the water has evaporated\\\\u2014about 7-8 minutes. When all the water has evaporated, uncover the pan, and increase heat to medium-high. Allow the pan to dry out even further, so that the bottoms of the dumplings crisp up again and are a nice golden brown. Serve.\\\",\\\"15\\\":\\\"If steaming, add the dumplings to a bamboo steamer lined with perforated parchment paper (fill up to 3 tiers of your steamer with dumplings!). Fill your wok with enough water to submerge the bottom of the bamboo steamer by about \\\\u00bd an inch (1.3cm), and bring the water to a boil. When the water is boiling, place the covered bamboo steamer into the wok, and steam for about 7 minutes for fresh dumplings, or 8 minutes for frozen dumplings. Serve.\\\"}\"', '[\"Gluten Free\",\"Meat\"]', 'gluten-free-dumplings', NULL),
(17, 'Three cup chicken', 'Three Cup Chicken, or San Bei Ji, is a popular Taiwanese/Chinese dish. The name refers to the recipe used to make it, including a cup each of the three ingredients that create the sauce: rice wine, soy sauce, and sesame oil.', 2, '2025-03-12 23:48:33', '2025-03-12 23:48:33', 'recipe_images/tgwQceLZ3zehspu2TFxK0dz6lSsrQCUWty8I75ga.jpg', '\"[\\\"Chicken\\\",\\\"Sesame oil\\\",\\\"Thai basil\\\",\\\"Rice wine\\\",\\\"Sugar\\\",\\\"Chili peppers\\\",\\\"Soy sauce\\\"]\"', '\"[\\\"Start by putting the sesame oil, vegetable oil, ginger, garlic, and red chili into your wok over medium heat. Let the aromatics infuse the oil for a couple minutes.\\\",\\\"Then turn up the heat to high, and add the chicken wings to the wok all in one layer. Sear the chicken until golden brown on both sides. Then add 1\\\\\\/4 cup warm water, \\\\u00bc cup Shaoxing wine, dark soy sauce (2-5 teaspoons, depending on how dark you\\\\u2019d like the dish to be), 1 1\\\\\\/2 tablespoons light soy sauce, and 2 teaspoons sugar.\\\",\\\"Stir and cover the wok. Turn the heat down to medium and simmer for 15 minutes to cook the chicken through (cook for 20 minutes if you want the chicken to be more tender).\\\",\\\"Then remove the cover and turn up the heat to rapidly reduce the sauce for a few minutes until it clings to the chicken and gives it a rich, dark color. Make sure to stir the chicken during this process to prevent burning.\\\",\\\"Throw in your Thai basil and\\\\\\/or scallions and fry another minute until it\\\\u2019s wilted. Serve!\\\"]\"', '[\"High in Protein\",\"Meat\"]', 'three-cup-chicken', NULL),
(18, 'Tomato Potato Soup', 'This simple tomato potato soup is a summer staple, with just 5 ingredients (plus water). It’s a light snack or side dish that replenishes your body with fluids and salt on hot days.', 2, '2025-03-13 00:45:28', '2025-03-13 00:45:28', 'recipe_images/GsYtURUCBGZ9TOji4xDCevPD7wyw16N2CQW9SG1w.jpg', '\"[\\\"tomatoes\\\",\\\"potatoes\\\",\\\"Oil\\\",\\\"Water\\\",\\\"Scallions\\\"]\"', '\"[\\\"Prepare the tomatoes and potatoes. If you\\\\u2019re not cooking the soup right away, keep the potatoes in a bowl of cold water to prevent them from oxidizing (turning brown).\\\",\\\"Heat oil in a medium soup pot over medium-high heat, and add the tomatoes. Cook for 3-5 minutes, until tomatoes have softened and broken down a bit.\\\",\\\"Add the water and potato, and bring to a boil over high heat. Once boiling, cover, reduce the heat to medium, and cook for 15 minutes. Finally, add the scallion and salt to taste (don\\\\u2019t be afraid to be generous with the salt). Serve hot or at room temperature!\\\"]\"', '[\"Vegan\"]', 'tomato-potato-soup', NULL),
(19, 'Chinese Lemon Chicken', 'This oft-requested Chinese lemon chicken recipe is a delicious, refreshing alternative to the usual crispy sweet and sour chicken.', 10, '2025-03-17 23:09:45', '2025-03-17 23:09:45', 'recipe_images/pMwOHewcC9sZfA3dS8gbR2zdGCw6vBIxihqhn0kb.jpg', '\"[\\\"Boneless skinless chicken breast\\\",\\\"Shaoxing wine\\\",\\\"Salt\\\",\\\"Garlic powder\\\",\\\"Sesame oil\\\",\\\"White pepper\\\",\\\"Cornstarch\\\",\\\"Neutral oil\\\",\\\"All-purpose flour\\\",\\\"Baking powder\\\",\\\"Cold beer \\\",\\\"Lemon\\\",\\\"Water\\\",\\\"White sugar\\\"]\"', '\"{\\\"0\\\":\\\"Marinate the chicken:\\\",\\\"2\\\":\\\"Toss the chicken in the Shaoxing wine, salt, garlic powder, sesame oil, cornstarch and white pepper. Set aside for 20 minutes (or overnight, if marinating in advance).\\\",\\\"3\\\":\\\"Fry the chicken:\\\",\\\"4\\\":\\\"For the batter fried version, combine \\\\u00bd cup of the flour, cornstarch, salt, baking powder, white pepper, and turmeric (if using). Just before you\\\\u2019re ready to fry, mix in the seltzer and sesame oil, just until the batter is smooth. Dredge the chicken in the remaining \\\\u00bc cup of flour. Heat a small pot of oil to 350\\\\u00b0F\\\\\\/175\\\\u00b0C. Drop 5-6 pieces of the marinated, dredged chicken into the batter, and use chopsticks, a fork, or your fingers to coat the chicken, placing each carefully into the oil. Adjust the heat to maintain the oil temperature at around 325\\\\u00b0F\\\\\\/160\\\\u00b0C (dropping the chicken into the oil will immediately lower the temperature).\\\",\\\"5\\\":\\\"For the crispy coating option, heat 1\\\\u00bd to 2 cups of oil in your wok for shallow frying, until it reaches 325\\\\u00b0F\\\\\\/160\\\\u00b0C. Combine the cornstarch, flour, salt, white pepper, turmeric, and sesame oil. Dredge the chicken in the dry mixture, and drop them into the oil, in batches of 5-6 pieces.\\\",\\\"7\\\":\\\"Use chopsticks or a slotted spoon to carefully turn the chicken pieces occasionally (in either case!), so all sides are uniformly fried. Fry for about 2 to 3 minutes, or until the chicken is light golden brown and crispy. Remove with a slotted spoon, and let any excess oil drain off before placing onto a rack or paper towel lined plate. Repeat until all the chicken has been fried.\\\",\\\"8\\\":\\\"Make the lemon sauce & assemble the dish:\\\",\\\"9\\\":\\\"Juice the lemon(s) until you get \\\\u00bc cup juice. Slice a few thin rounds of lemon (about \\\\u215b-inch\\\\\\/3mm thick), and zest the remainder so you have about 1 teaspoon. Slice the rounds into sixths, so you have small wedge slices. Add the juice, zest, and slices to a non-reactive\\\\\\/stainless steel saucepan over medium-high heat, along with the water, sugar, and salt. Bring to a simmer.\\\",\\\"10\\\":\\\"While the sauce is coming up to a simmer, reheat your oil to 350\\\\u00b0F\\\\\\/175\\\\u00b0C. Fry your chicken into the oil in 2 batches, re-frying each batch, maintaining the heat at at least 325\\\\u00b0F\\\\\\/160\\\\u00b0C for 2 minutes, or until crispy.\\\",\\\"11\\\":\\\"With the lemon sauce still simmering, slowly stir in the cornstarch slurry until the sauce is thick enough to coat a spoon. If the sauce thickens to this point before you add all of the slurry, don\\\\u2019t add the remainder; just discard it! You can do this while the chicken is frying for the second time.\\\",\\\"12\\\":\\\"Once all the chicken is fried, toss it into the sauce, and fold it in with 3-4 scooping motions, until the pieces are lightly coated. Plate and serve immediately! If you like, you can garnish with additional fresh lemon slices.\\\"}\"', '[\"High in Protein\",\"Meat\"]', 'chinese-lemon-chicken', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `recipes_ingredients`
--

CREATE TABLE `recipes_ingredients` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `recipe_id` bigint(20) UNSIGNED NOT NULL,
  `ingredient_id` bigint(20) UNSIGNED NOT NULL,
  `quantity` double NOT NULL,
  `unit` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `saved_recipes`
--

CREATE TABLE `saved_recipes` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `recipe_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `saved_recipes`
--

INSERT INTO `saved_recipes` (`id`, `user_id`, `recipe_id`, `created_at`, `updated_at`) VALUES
(2, 2, 6, '2025-03-17 21:16:26', '2025-03-17 21:16:26'),
(3, 2, 11, '2025-03-17 21:16:37', '2025-03-17 21:16:37'),
(4, 2, 13, '2025-03-17 21:22:15', '2025-03-17 21:22:15'),
(5, 2, 12, '2025-03-17 21:22:36', '2025-03-17 21:22:36'),
(6, 2, 18, '2025-03-17 21:22:40', '2025-03-17 21:22:40'),
(7, 10, 6, '2025-03-17 23:16:57', '2025-03-17 23:16:57');

-- --------------------------------------------------------

--
-- Table structure for table `sessions`
--

CREATE TABLE `sessions` (
  `id` varchar(255) NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `payload` longtext NOT NULL,
  `last_activity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sessions`
--

INSERT INTO `sessions` (`id`, `user_id`, `ip_address`, `user_agent`, `payload`, `last_activity`) VALUES
('n7R9MB0Q8Y552rKytKnY7pMekiXiQbIiangrzzsu', 10, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36', 'YTo1OntzOjY6Il90b2tlbiI7czo0MDoib0tNMEV5Q3lGaHZMcUV6MTIwZkZVaU02RkZDcVpSc1d1aHRyakcwZCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjE6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fXM6MzoidXJsIjthOjE6e3M6ODoiaW50ZW5kZWQiO3M6Mjk6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC9yZWNpcGVzIjt9czo1MDoibG9naW5fd2ViXzU5YmEzNmFkZGMyYjJmOTQwMTU4MGYwMTRjN2Y1OGVhNGUzMDk4OWQiO2k6MTA7fQ==', 1742253600);

-- --------------------------------------------------------

--
-- Table structure for table `substitutions`
--

CREATE TABLE `substitutions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `recipe_id` bigint(20) UNSIGNED NOT NULL,
  `primary_ingredient` varchar(255) NOT NULL,
  `substitute` varchar(255) NOT NULL,
  `compatibility` int(11) NOT NULL,
  `criteria` text NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `substitutions`
--

INSERT INTO `substitutions` (`id`, `recipe_id`, `primary_ingredient`, `substitute`, `compatibility`, `criteria`, `created_at`, `updated_at`) VALUES
(1, 5, 'Clam', 'Fish', 2, 'Similar flavor profile, rich, slightly different texture', '2025-02-25 00:11:42', '2025-02-25 00:11:42'),
(2, 5, 'Clam', 'Mussels', 2, 'Similar protein source, but different texture', '2025-02-25 00:11:42', '2025-02-25 00:11:42'),
(3, 5, 'Tofu', 'Seitan', 3, 'Different texture, higher protein, dietary restriction', '2025-02-25 00:11:42', '2025-02-25 00:11:42'),
(4, 5, 'Ginger', 'Galangal', 2, 'Slightly different but similar aromatic profile', '2025-02-25 00:11:42', '2025-02-25 00:11:42'),
(5, 5, 'Cook wine', 'Rice Vinegar', 1, 'Different taste but can substitute for acidity', '2025-02-25 00:11:42', '2025-02-25 00:11:42'),
(6, 5, 'Bok choy', 'Napa cabbage', 2, 'Similar leafy texture, different water content', '2025-02-25 00:11:42', '2025-02-25 00:11:42'),
(7, 5, 'Salt', 'Himalayan Salt', 2, 'Low in sodium, similar salty profile', '2025-02-25 00:11:42', '2025-02-25 00:11:42'),
(8, 6, 'Bok choy', 'Napa cabbage', 2, 'Similar texture but slightly milder flavor', '2025-02-25 00:22:33', '2025-02-25 00:22:33'),
(9, 6, 'Oil', 'Avocado oil', 3, 'Healthier option, neutral taste and high heat tolerance', '2025-02-25 00:22:33', '2025-02-25 00:22:33'),
(10, 6, 'Garlic', 'Shallots', 2, 'Milder, but similar aromatic quality', '2025-02-25 00:22:33', '2025-02-25 00:22:33'),
(11, 6, 'Ginger', 'Galangal', 2, 'Slightly different flavor profile, but still pungent and spicy', '2025-02-25 00:22:33', '2025-02-25 00:22:33'),
(12, 6, 'Salt', 'Himalayan Salt', 2, 'Low in sodium, similar salty profile', '2025-02-25 00:22:33', '2025-02-25 00:22:33'),
(13, 6, 'Seasame oil', 'Perilla oil', 3, 'Flavor profile (rich, nutty),Healthier option (contain omega-3)', '2025-02-25 00:22:33', '2025-02-25 00:22:33'),
(14, 6, 'MSG', 'Soy sauce', 2, 'Umami-rich, but adds a touch of saltiness', '2025-02-25 00:22:33', '2025-02-25 00:22:33'),
(15, 6, 'Cornstarch', 'Arrowroot powder', 2, 'Similar thickening properties, but with a slightly different texture', '2025-02-25 00:22:33', '2025-02-25 00:22:33'),
(16, 6, 'White pepper', 'Black pepper', 2, 'More common, similar heat but different flavor profile', '2025-02-25 00:22:33', '2025-02-25 00:22:33'),
(17, 7, 'Oil', 'Coconut oil', 3, 'Similar tropical flavor, healthier (high in antioxidants)', '2025-03-06 21:07:17', '2025-03-06 21:07:17'),
(18, 7, 'Oil', 'Olive oil', 2, 'Healthier option, but different flavor profile', '2025-03-06 21:07:17', '2025-03-06 21:07:17'),
(19, 7, 'Shrimp', 'Tofu', 3, 'Vegan option, different texture but a solid protein replacement', '2025-03-06 21:07:17', '2025-03-06 21:07:17'),
(20, 7, 'Shrimp', 'Chicken Breast', 2, 'Similar texture, different flavor, non-seafood alternative', '2025-03-06 21:07:17', '2025-03-06 21:07:17'),
(21, 7, 'Garlic', 'Garlic powder', 1, 'Flavor replacement, lacks texture', '2025-03-06 21:07:17', '2025-03-06 21:07:17'),
(22, 7, 'Garlic', 'Galangal', 2, 'Similar flavor, used in Thai cuisine, slightly more aromatic', '2025-03-06 21:07:17', '2025-03-06 21:07:17'),
(23, 7, 'Red bell pepper', 'Yellow bell pepper', 2, 'Similar texture, different color and slightly sweeter', '2025-03-06 21:07:17', '2025-03-06 21:07:17'),
(24, 7, 'Brown sugar', 'Coconut sugar', 3, 'Healthier option, similar sweetness', '2025-03-06 21:07:17', '2025-03-06 21:07:17'),
(25, 7, 'Brown sugar', 'Maple syrup', 2, 'Different texture but similar natural sweetness', '2025-03-06 21:07:17', '2025-03-06 21:07:17'),
(26, 7, 'Thai red curry paste', 'Yellow curry paste', 2, 'Milder flavor but similar spice base', '2025-03-06 21:07:17', '2025-03-06 21:07:17'),
(27, 7, 'Thai red curry paste', 'Green curry paste', 2, 'Similar but more herbaceous', '2025-03-06 21:07:17', '2025-03-06 21:07:17'),
(28, 8, 'Dried shiitake mushrooms', 'Fresh shiitake mushrooms', 2, 'Slightly less concentrated flavor, but similar texture and umami', '2025-03-06 22:22:53', '2025-03-06 22:22:53'),
(29, 8, 'Dried shiitake mushrooms', 'Portobello mushrooms', 3, 'Different flavor, but meaty texture, adds depth to the dish', '2025-03-06 22:22:53', '2025-03-06 22:22:53'),
(30, 8, 'Ground pork', 'Ground chicken', 3, 'Leaner, lighter flavor, works well as a substitute', '2025-03-06 22:22:53', '2025-03-06 22:22:53'),
(31, 8, 'Ground pork', 'Ground turkey', 2, 'Similar texture, leaner meat, slightly different flavor', '2025-03-06 22:22:53', '2025-03-06 22:22:53'),
(32, 8, 'Ground pork', 'Tofu (crumbled)', 3, 'Vegan option, absorbs flavors well', '2025-03-06 22:22:53', '2025-03-06 22:22:53'),
(33, 8, 'Dark soy sauce', 'Mushroom soy sauce', 2, 'Adds depth with an umami flavor', '2025-03-06 22:22:53', '2025-03-06 22:22:53'),
(34, 8, 'Dark soy sauce', 'Double black soy sauce', 3, 'Richer, thicker, adds deep color and flavor', '2025-03-06 22:22:53', '2025-03-06 22:22:53'),
(35, 8, 'Sesame oil', 'Olive oil', 3, 'Healthier option, different flavor', '2025-03-06 22:22:53', '2025-03-06 22:22:53'),
(36, 8, 'Sesame oil', 'Perilla oil', 3, 'Nutty flavor, similar in aroma', '2025-03-06 22:22:53', '2025-03-06 22:22:53'),
(37, 8, 'Shaoxing wine', 'Mirin', 2, 'Sweeter, less alcoholic but can work as a cooking wine substitute', '2025-03-06 22:22:53', '2025-03-06 22:22:53'),
(38, 8, 'Oil', 'Olive oil', 2, 'Healthier option, but different flavor profile', '2025-03-06 22:22:53', '2025-03-06 22:22:53'),
(39, 8, 'Salt', 'Himalayan Salt', 2, 'Low in sodium, similar salty profile', '2025-03-06 22:22:53', '2025-03-06 22:22:53'),
(40, 8, 'Garlic', 'Shallots', 2, 'Milder, but similar aromatic quality', '2025-03-06 22:22:53', '2025-03-06 22:22:53'),
(41, 8, 'Ginger', 'Galangal', 2, 'Slightly different flavor profile, but still pungent and spicy', '2025-03-06 22:22:53', '2025-03-06 22:22:53'),
(42, 8, 'Chinese bitter melon', 'Zucchini', 2, 'Milder flavor, similar texture, different bitterness', '2025-03-06 22:22:53', '2025-03-06 22:22:53'),
(43, 8, 'Chinese bitter melon', 'Bell peppers (hollowed out)', 2, 'Different flavor, but can be stuffed similarly', '2025-03-06 22:22:53', '2025-03-06 22:22:53'),
(44, 8, 'Whole fermented black beans', 'Miso paste', 2, 'Different texture, but similar umami-rich fermented flavor', '2025-03-06 22:22:53', '2025-03-06 22:22:53'),
(45, 8, 'Sugar', 'Honey', 2, 'Natural sweetener, similar sweetness', '2025-03-06 22:22:53', '2025-03-06 22:22:53'),
(46, 8, 'Chicken stock', 'Vegetable stock', 3, 'Vegan substitute, similar flavor base', '2025-03-06 22:22:53', '2025-03-06 22:22:53'),
(59, 10, 'Shrimp', 'Tofu', 3, 'Vegan option, different texture, but can absorb similar flavors', '2025-03-10 18:38:05', '2025-03-10 18:38:05'),
(60, 10, 'Shrimp', 'Seitan', 2, 'Similar protein source, but different texture', '2025-03-10 18:38:05', '2025-03-10 18:38:05'),
(61, 10, 'Eggs', 'Silken tofu', 3, 'Vegan option, similar creamy texture in scrambled form', '2025-03-10 18:38:05', '2025-03-10 18:38:05'),
(62, 10, 'Soy sauce', 'Tamari', 2, 'Gluten-free, similar flavor profile', '2025-03-10 18:38:05', '2025-03-10 18:38:05'),
(63, 10, 'Soy sauce', 'Coconut Aminos', 3, 'Healthier, lower sodium, soy-free', '2025-03-10 18:38:05', '2025-03-10 18:38:05'),
(64, 10, 'Sesame oil', 'Olive oil', 2, 'Healthier option, different flavor', '2025-03-10 18:38:05', '2025-03-10 18:38:05'),
(65, 10, 'Sesame oil', 'Perilla oil', 3, 'Nutty flavor, similar in aroma', '2025-03-10 18:38:05', '2025-03-10 18:38:05'),
(66, 10, 'Scallions', 'Chives', 2, 'Milder flavor but similar freshness', '2025-03-10 18:38:05', '2025-03-10 18:38:05'),
(67, 10, 'Scallions', 'Leeks', 2, 'Slightly different texture, milder flavor', '2025-03-10 18:38:05', '2025-03-10 18:38:05'),
(68, 10, 'Cornstarch', 'Potato starch', 3, 'Similar thickening agent, works in the same way', '2025-03-10 18:38:05', '2025-03-10 18:38:05'),
(69, 10, 'Cornstarch', 'Arrowroot powder', 3, 'Gluten-free, healthier alternative for thickening', '2025-03-10 18:38:05', '2025-03-10 18:38:05'),
(70, 11, 'Soy sauce', 'Tamari', 2, 'Flavor profile (rich, thick texture and nuanced salinity)', '2025-03-10 18:43:53', '2025-03-10 18:43:53'),
(71, 11, 'Soy sauce', 'Coconut Aminos', 3, 'Healthier option (low in sodium),Dietary restriction(soy-free, gluten-free)', '2025-03-10 18:43:53', '2025-03-10 18:43:53'),
(72, 11, 'Vegetable oil', 'Seasame oil', 2, 'Flavor profile (rich)', '2025-03-10 18:43:53', '2025-03-10 18:43:53'),
(73, 11, 'Chicken', 'Seitan', 3, 'Different texture, Healthier option (richest in protein), Dietary restriction(vegan)', '2025-03-10 18:43:53', '2025-03-10 18:43:53'),
(74, 11, 'Chicken', 'Tofu', 2, 'Dietary restriction(vegan)', '2025-03-10 18:43:53', '2025-03-10 18:43:53'),
(75, 11, 'Sugar', 'Honey', 2, 'Flavor profile (natural sweetener)', '2025-03-10 18:43:53', '2025-03-10 18:43:53'),
(76, 11, 'Sugar', 'Maple syrup', 2, 'Flavor profile (natural sweetener)', '2025-03-10 18:43:53', '2025-03-10 18:43:53'),
(77, 11, 'Sugar', 'Stevia', 3, 'Dietary restriction (sugar-free)', '2025-03-10 18:43:53', '2025-03-10 18:43:53'),
(78, 12, 'Shrimp', 'Tofu', 3, 'Vegan option, different texture but absorbs flavors well', '2025-03-10 18:52:59', '2025-03-10 18:52:59'),
(79, 12, 'Shrimp', 'Seitan', 2, 'Similar protein source, but different texture', '2025-03-10 18:52:59', '2025-03-10 18:52:59'),
(80, 12, 'Light Soy sauce', 'Tamari', 2, 'Gluten-free, similar flavor profile', '2025-03-10 18:52:59', '2025-03-10 18:52:59'),
(81, 12, 'Light Soy sauce', 'Coconut Aminos', 3, 'Healthier, lower sodium, soy-free', '2025-03-10 18:52:59', '2025-03-10 18:52:59'),
(82, 12, 'Dark soy sauce', 'Mushroom soy sauce', 2, 'Adds depth with an umami flavor', '2025-03-10 18:52:59', '2025-03-10 18:52:59'),
(83, 12, 'Dark soy sauce', 'Double black soy sauce', 3, 'Richer, thicker, adds deep color and flavor', '2025-03-10 18:52:59', '2025-03-10 18:52:59'),
(84, 12, 'Scallions', 'Chives', 2, 'Milder flavor but similar freshness', '2025-03-10 18:52:59', '2025-03-10 18:52:59'),
(85, 12, 'Scallions', 'Leeks', 2, 'Slightly different texture, milder flavor', '2025-03-10 18:52:59', '2025-03-10 18:52:59'),
(86, 12, 'Oil', 'Olive oil', 2, 'Healthier option, but different flavor profile', '2025-03-10 18:52:59', '2025-03-10 18:52:59'),
(87, 12, 'Oil', 'Avocado oil', 3, 'Healthier option, neutral taste and high heat tolerance', '2025-03-10 18:52:59', '2025-03-10 18:52:59'),
(88, 12, 'Garlic', 'Shallots', 2, 'Milder, but similar aromatic quality', '2025-03-10 18:52:59', '2025-03-10 18:52:59'),
(89, 12, 'Ginger', 'Galangal', 2, 'Slightly different flavor profile, but still pungent and spicy', '2025-03-10 18:52:59', '2025-03-10 18:52:59'),
(90, 12, 'Rice wine vinegar', 'Apple cider vinegar', 3, 'Similar acidity, slightly sweeter flavor', '2025-03-10 18:52:59', '2025-03-10 18:52:59'),
(91, 12, 'Rice wine vinegar', 'White vinegar', 2, 'More acidic, but works as a substitute', '2025-03-10 18:52:59', '2025-03-10 18:52:59'),
(92, 12, 'Dried red chilies', 'Fresh red chilies (dried or sliced)', 2, 'Fresher, slightly less spicy, but can work in stir-fries', '2025-03-10 18:52:59', '2025-03-10 18:52:59'),
(93, 12, 'Dried red chilies', 'Chili flakes (crushed red pepper)', 3, 'Easier to find, provides a similar level of heat', '2025-03-10 18:52:59', '2025-03-10 18:52:59'),
(94, 12, 'Cornstarch', 'Potato starch', 3, 'Similar thickening agent, works in the same way', '2025-03-10 18:52:59', '2025-03-10 18:52:59'),
(95, 12, 'Cornstarch', 'Arrowroot powder', 3, 'Gluten-free, healthier alternative for thickening', '2025-03-10 18:52:59', '2025-03-10 18:52:59'),
(96, 13, 'Cornstarch', 'Potato starch', 3, 'Similar thickening agent, works in the same way', '2025-03-11 19:57:34', '2025-03-11 19:57:34'),
(97, 14, 'Boneless skinless chicken thighs', 'Tofu', 3, 'Vegan option, different texture but absorbs flavors well', '2025-03-11 21:51:52', '2025-03-11 21:51:52'),
(98, 14, 'Boneless skinless chicken thighs', 'Seitan', 2, 'Similar protein source, but different texture', '2025-03-11 21:51:52', '2025-03-11 21:51:52'),
(99, 14, 'Shaoxing wine', 'Mirin', 2, 'Sweeter, less alcoholic but can work as a cooking wine substitute', '2025-03-11 21:51:52', '2025-03-11 21:51:52'),
(100, 14, 'Soy sauce', 'Tamari', 2, 'Gluten-free, similar flavor profile', '2025-03-11 21:51:52', '2025-03-11 21:51:52'),
(101, 14, 'Soy sauce', 'Coconut Aminos', 3, 'Healthier, lower sodium, soy-free', '2025-03-11 21:51:52', '2025-03-11 21:51:52'),
(102, 14, 'Sesame oil', 'Olive oil', 2, 'Healthier option, different flavor', '2025-03-11 21:51:52', '2025-03-11 21:51:52'),
(103, 14, 'Scallions', 'Leeks', 2, 'Slightly different texture, milder flavor', '2025-03-11 21:51:52', '2025-03-11 21:51:52'),
(104, 14, 'Oil', 'Avocado oil', 3, 'Healthier option, neutral taste and high heat tolerance', '2025-03-11 21:51:52', '2025-03-11 21:51:52'),
(105, 14, 'Oyster sauce', 'Vegan Oyster sauce', 3, 'A plant-based alternative to traditional oyster sauce', '2025-03-11 21:51:52', '2025-03-11 21:51:52'),
(106, 14, 'Chinese fermented black beans', 'Miso paste', 3, 'Similar umami, salty depth of flavor', '2025-03-11 21:51:52', '2025-03-11 21:51:52'),
(107, 14, 'Sugar', 'Maple syrup', 2, 'Natural sweetener, slightly different flavor', '2025-03-11 21:51:52', '2025-03-11 21:51:52'),
(108, 15, 'Beef flank steak', 'Tofu', 2, 'Vegan option, absorbs flavors well', '2025-03-11 22:08:20', '2025-03-11 22:08:20'),
(109, 15, 'Cornstarch', 'Potato starch', 3, 'Similar thickening agent, works in the same way', '2025-03-11 22:08:20', '2025-03-11 22:08:20'),
(110, 15, 'Oil', 'Olive oil', 2, 'Healthier option, but different flavor profile', '2025-03-11 22:08:20', '2025-03-11 22:08:20'),
(111, 15, 'Oyster sauce', 'Vegan Oyster Sauce', 3, 'A plant-based alternative to traditional oyster sauce', '2025-03-11 22:08:20', '2025-03-11 22:08:20'),
(112, 15, 'light soy sauce', 'Tamari', 2, 'Gluten-free, similar flavor profile', '2025-03-11 22:08:20', '2025-03-11 22:08:20'),
(113, 15, 'Shaoxing wine', 'Mirin', 2, 'Sweeter, less alcoholic but can work as a cooking wine substitute', '2025-03-11 22:08:20', '2025-03-11 22:08:20'),
(114, 15, 'canned julienned bamboo shoots', 'Celery', 2, 'Crisp texture, but different flavor profile', '2025-03-11 22:08:20', '2025-03-11 22:08:20'),
(115, 15, 'dark soy sauce', 'Mushroom soy sauce', 2, 'Adds depth with an umami flavor', '2025-03-11 22:08:20', '2025-03-11 22:08:20'),
(116, 16, 'Gluten-free flour (King Arthur)', 'Bob’s Red Mill gluten-free flour', 3, 'Similar texture, another popular gluten-free flour blend', '2025-03-11 22:16:31', '2025-03-11 22:16:31'),
(117, 16, 'Tapioca starch', 'Cornstarch', 2, 'Similar thickening and binding properties', '2025-03-11 22:16:31', '2025-03-11 22:16:31'),
(118, 16, 'Tapioca starch', 'Arrowroot powder', 2, 'Similar texture, commonly used in gluten-free recipes', '2025-03-11 22:16:31', '2025-03-11 22:16:31'),
(119, 16, 'Glutinous rice flour', 'Sweet rice flour', 3, 'Same texture, commonly interchangeable', '2025-03-11 22:16:31', '2025-03-11 22:16:31'),
(120, 16, 'Xanthan gum in gluten free', 'Psyllium husk powder', 2, 'Similar gluten-replacement for binding, adds fiber', '2025-03-11 22:16:31', '2025-03-11 22:16:31'),
(121, 16, 'Xanthan gum in gluten free', 'Guar gum', 2, 'Gluten-free alternative with similar binding properties', '2025-03-11 22:16:31', '2025-03-11 22:16:31'),
(122, 16, 'Mince pork (20% fat)', 'Vegan ground meat (e.g., Beyond Meat, Impossible Burger)', 3, 'High in protein, similar texture, vegan and plant-based', '2025-03-11 22:16:31', '2025-03-11 22:16:31'),
(123, 16, 'Mince pork (20% fat)', 'Minced turkey (20% fat)', 2, 'Earthy flavor, similar texture when combined, vegan option', '2025-03-11 22:16:31', '2025-03-11 22:16:31'),
(124, 17, 'Chicken', 'Tofu', 3, 'Vegan option, different texture, but can absorb similar flavors', '2025-03-12 23:48:33', '2025-03-12 23:48:33'),
(125, 17, 'Chicken', 'Seitan', 3, 'Vegan option, more meaty texture, protein-rich', '2025-03-12 23:48:33', '2025-03-12 23:48:33'),
(126, 17, 'Sesame oil', 'Olive oil', 2, 'Healthier option, different flavor profile', '2025-03-12 23:48:33', '2025-03-12 23:48:33'),
(127, 17, 'Sesame oil', 'Perilla oil', 3, 'Rich, nutty flavor, similar in aroma', '2025-03-12 23:48:33', '2025-03-12 23:48:33'),
(128, 17, 'Thai basil', 'Regular basil', 2, 'Similar flavor, but not as spicy or pungent', '2025-03-12 23:48:33', '2025-03-12 23:48:33'),
(129, 17, 'Thai basil', 'Cilantro', 1, 'Different flavor profile, provides freshness', '2025-03-12 23:48:33', '2025-03-12 23:48:33'),
(130, 17, 'Rice wine', 'Apple cider vinegar', 2, 'Similar acidity, different flavor', '2025-03-12 23:48:33', '2025-03-12 23:48:33'),
(131, 17, 'Sugar', 'Honey', 3, 'Natural sweetener, similar sweetness', '2025-03-12 23:48:33', '2025-03-12 23:48:33'),
(132, 17, 'Sugar', 'Maple syrup', 2, 'Natural sweetener, slightly different flavor', '2025-03-12 23:48:33', '2025-03-12 23:48:33'),
(133, 17, 'Chili peppers', 'Red pepper flakes', 2, 'Similar spiciness, easier to use', '2025-03-12 23:48:33', '2025-03-12 23:48:33'),
(134, 17, 'Soy sauce', 'Tamari', 2, 'Gluten-free, similar flavor profile', '2025-03-12 23:48:33', '2025-03-12 23:48:33'),
(135, 17, 'Soy sauce', 'Coconut Aminos', 3, 'Healthier, lower sodium, soy-free', '2025-03-12 23:48:33', '2025-03-12 23:48:33'),
(136, 18, 'tomatoes', 'Tomato paste + water', 2, 'Stronger flavor, may need to adjust for balance', '2025-03-13 00:45:28', '2025-03-13 00:45:28'),
(137, 18, 'potatoes', 'Sweet potatoes', 2, 'Different flavor, adds natural sweetness', '2025-03-13 00:45:28', '2025-03-13 00:45:28'),
(138, 18, 'Oil', 'Olive oil', 2, 'Healthier option, but different flavor profile', '2025-03-13 00:45:28', '2025-03-13 00:45:28'),
(139, 18, 'Oil', 'Avocado oil', 2, 'Healthier option, neutral taste and high heat tolerance', '2025-03-13 00:45:28', '2025-03-13 00:45:28'),
(140, 18, 'Scallions', 'Chives', 2, 'Milder flavor but similar freshness', '2025-03-13 00:45:28', '2025-03-13 00:45:28'),
(141, 19, 'Boneless skinless chicken breast', 'Tofu', 2, 'Vegan option, different texture but absorbs flavors well', '2025-03-17 23:09:45', '2025-03-17 23:09:45'),
(142, 19, 'Shaoxing wine', 'Mirin', 2, 'Sweeter, less alcoholic but can work as a cooking wine substitute', '2025-03-17 23:09:45', '2025-03-17 23:09:45'),
(143, 19, 'Sesame oil', 'Olive oil', 1, 'Healthier option, different flavor', '2025-03-17 23:09:45', '2025-03-17 23:09:45'),
(144, 19, 'Cornstarch', 'Potato starch', 3, 'Similar thickening agent, works in the same way', '2025-03-17 23:09:45', '2025-03-17 23:09:45'),
(145, 19, 'Neutral oil', 'Avocado oil', 3, 'Healthier option, neutral taste and high heat tolerance', '2025-03-17 23:09:45', '2025-03-17 23:09:45'),
(146, 19, 'All-purpose flour', 'Whole Wheat Flour:', 1, 'Whole wheat flour adds a nutty flavor and fiber, so it can be used as a partial substitute for all-purpose flour, often mixed with bread flour for better structure', '2025-03-17 23:09:45', '2025-03-17 23:09:45'),
(147, 19, 'Baking powder', 'Buttermilk and Baking Soda', 2, 'Use 1/2 cup of buttermilk with 1/4 teaspoon of baking soda to replace 1 teaspoon of baking powder.', '2025-03-17 23:09:45', '2025-03-17 23:09:45'),
(148, 19, 'Cold beer', 'Ginger Ale', 2, 'A good option for a slightly sweeter, ginger-flavored substitute.', '2025-03-17 23:09:45', '2025-03-17 23:09:45'),
(149, 19, 'Lemon', 'Lime Juice', 3, 'often considered the closest substitute for lemon juice, with a similar taste and acidity leve', '2025-03-17 23:09:45', '2025-03-17 23:09:45'),
(150, 19, 'White sugar', 'Honey', 2, 'Natural sweetener, similar sweetness', '2025-03-17 23:09:45', '2025-03-17 23:09:45');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `username` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` varchar(255) NOT NULL DEFAULT 'user',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `allergies` varchar(255) DEFAULT NULL,
  `cooking_skill` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `email`, `password`, `role`, `created_at`, `updated_at`, `allergies`, `cooking_skill`) VALUES
(2, 'k3n_0103', 'lokhimwong13@gmail.com', '$2y$12$aViFGFIqx0LgiIVlrKTcBuF5XQ1IjoBIG30/DiOQmZNQa1IpUIDnm', 'user', '2025-02-23 22:05:27', '2025-02-23 22:05:27', 'Shrimp', 'Beginner'),
(3, 'Sharon', 'yanbb113@gmail.com', '$2y$12$hAl4Va73zkTJfQZRNVHQ5O3cx/yFSXUx/Wjc4g2EaL42ug2DILb5i', 'user', '2025-03-05 23:12:39', '2025-03-05 23:12:39', 'None', 'Expert'),
(4, 'kk', 'kk13579@gmail.com', 'kenken123', 'user', '2025-03-05 23:18:38', '2025-03-05 23:18:38', 'None', 'Intermediate'),
(5, 'Tang san', 'Tangsan@yahoo.com.uk', '123456', 'user', '2025-03-05 23:20:04', '2025-03-05 23:20:04', 'None', 'Intermediate'),
(6, 'yuu', 'yuu@gmail.com', 'yuuyuu', 'user', '2025-03-05 23:25:02', '2025-03-05 23:25:02', 'None', 'Intermediate'),
(7, 'aa', 'aa@gmail.com', '$2y$12$QFZ.ACnz6vMFFQDphqLETOlvjOLK0GMZjNkMjxN2G0Xu9zN5aoEkW', 'user', '2025-03-06 21:01:12', '2025-03-06 21:01:12', 'Nuts', 'Intermediate'),
(8, 't3t', 't3t@yahoo.com', '$2y$12$4OgyjwZQhTHvlCcMdXuct.N1UmBTNP.cP8UYWaM/SdguTP7R9za4.', 'user', '2025-03-11 21:55:23', '2025-03-11 21:55:23', 'Nuts', 'Beginner'),
(9, 'htt', 'htt@yyy.gmail.com', '$2y$12$KCUN6zJIjfOjBpPuevCeguIf6DvC2sMV9bO55BbIdZXSOKF1zFgt.', 'user', '2025-03-16 23:09:47', '2025-03-16 23:09:47', 'Cashew', 'Expert'),
(10, 'astondabest', 'aston123@outlook.com', '$2y$12$lRxu5DMC.HfbPjFy7L3ZOuCax5szJWDXu9leUiHjYUBaow52yUwte', 'user', '2025-03-17 21:54:08', '2025-03-17 21:54:08', 'Shrimp', 'Beginner');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `cache`
--
ALTER TABLE `cache`
  ADD PRIMARY KEY (`key`);

--
-- Indexes for table `cache_locks`
--
ALTER TABLE `cache_locks`
  ADD PRIMARY KEY (`key`);

--
-- Indexes for table `comments`
--
ALTER TABLE `comments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `comments_recipe_id_foreign` (`recipe_id`),
  ADD KEY `comments_user_id_foreign` (`user_id`);

--
-- Indexes for table `ingredients`
--
ALTER TABLE `ingredients`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `ingredient_substitutions`
--
ALTER TABLE `ingredient_substitutions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `ingredient_substitutions_ingredient_id_foreign` (`ingredient_id`),
  ADD KEY `ingredient_substitutions_substitute_ingredient_id_foreign` (`substitute_ingredient_id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `recipes`
--
ALTER TABLE `recipes`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `slug` (`slug`),
  ADD KEY `recipes_created_by_foreign` (`created_by`);

--
-- Indexes for table `recipes_ingredients`
--
ALTER TABLE `recipes_ingredients`
  ADD PRIMARY KEY (`id`),
  ADD KEY `recipes_ingredients_recipe_id_foreign` (`recipe_id`),
  ADD KEY `recipes_ingredients_ingredient_id_foreign` (`ingredient_id`);

--
-- Indexes for table `saved_recipes`
--
ALTER TABLE `saved_recipes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `saved_recipes_user_id_foreign` (`user_id`),
  ADD KEY `saved_recipes_recipe_id_foreign` (`recipe_id`);

--
-- Indexes for table `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sessions_user_id_index` (`user_id`),
  ADD KEY `sessions_last_activity_index` (`last_activity`);

--
-- Indexes for table `substitutions`
--
ALTER TABLE `substitutions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `substitutions_recipe_id_foreign` (`recipe_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_username_unique` (`username`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `comments`
--
ALTER TABLE `comments`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `ingredients`
--
ALTER TABLE `ingredients`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ingredient_substitutions`
--
ALTER TABLE `ingredient_substitutions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `recipes`
--
ALTER TABLE `recipes`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `recipes_ingredients`
--
ALTER TABLE `recipes_ingredients`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `saved_recipes`
--
ALTER TABLE `saved_recipes`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `substitutions`
--
ALTER TABLE `substitutions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=151;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `comments`
--
ALTER TABLE `comments`
  ADD CONSTRAINT `comments_recipe_id_foreign` FOREIGN KEY (`recipe_id`) REFERENCES `recipes` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `comments_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `ingredient_substitutions`
--
ALTER TABLE `ingredient_substitutions`
  ADD CONSTRAINT `ingredient_substitutions_ingredient_id_foreign` FOREIGN KEY (`ingredient_id`) REFERENCES `ingredients` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `ingredient_substitutions_substitute_ingredient_id_foreign` FOREIGN KEY (`substitute_ingredient_id`) REFERENCES `ingredients` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `recipes`
--
ALTER TABLE `recipes`
  ADD CONSTRAINT `recipes_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `recipes_ingredients`
--
ALTER TABLE `recipes_ingredients`
  ADD CONSTRAINT `recipes_ingredients_ingredient_id_foreign` FOREIGN KEY (`ingredient_id`) REFERENCES `ingredients` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `recipes_ingredients_recipe_id_foreign` FOREIGN KEY (`recipe_id`) REFERENCES `recipes` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `saved_recipes`
--
ALTER TABLE `saved_recipes`
  ADD CONSTRAINT `saved_recipes_recipe_id_foreign` FOREIGN KEY (`recipe_id`) REFERENCES `recipes` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `saved_recipes_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `substitutions`
--
ALTER TABLE `substitutions`
  ADD CONSTRAINT `substitutions_recipe_id_foreign` FOREIGN KEY (`recipe_id`) REFERENCES `recipes` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
