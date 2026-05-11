# leanagents.dev

Community site for the [Lean Agents](https://leanagents.dev) movement
— resource-efficient AI agent runtimes built with compiled languages.

## Development

Prerequisites: [Hugo](https://gohugo.io/) v0.161.1+ (extended),
[Go](https://go.dev/) 1.26+

```bash
hugo server -D
```

## Deployment

Deployed to [Cloudflare Workers](https://workers.cloudflare.com/)
from the `main` branch. Build configuration is in `wrangler.toml`
and `build.sh`.

## Theme

[Blowfish](https://blowfish.page/) installed via Hugo modules.

## Adding a project

Create a new project page:

```bash
hugo new projects/your-project/index.md
```

Add a `featured.png` (329:219 aspect ratio) to the same directory.

## License

[CC BY 4.0](LICENSE)
