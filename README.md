# Discourse K-pop Lottery Plugin

This plugin adds a lottery feature to your Discourse forum, perfect for K-pop fan communities.

## Features

- Start a lottery on any topic
- Automatically select a winner from eligible posts
- Customizable lottery duration and minimum post requirement

## Installation

Follow [Install a Plugin](https://meta.discourse.org/t/install-a-plugin/19157) guide, using `git clone https://github.com/yourusername/discourse-kpop-lottery.git` as the plugin command.

## Usage

1. As an admin, go to a topic where you want to start a lottery.
2. Click the "Start Lottery" button on the first post.
3. When the lottery duration has passed, use the admin interface to draw a winner.

## Settings

Visit your admin settings page to configure the plugin:

- `kpop_lottery_enabled`: Enable or disable the plugin
- `kpop_lottery_duration`: Set the default duration for lotteries (in days)
- `kpop_lottery_min_posts`: Set the minimum number of posts required for a valid lottery

## License

MIT
