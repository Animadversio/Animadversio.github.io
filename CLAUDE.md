# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a Hugo-based academic website using the Hugo Blox Builder (Academic CV theme). The site is deployed on Netlify and serves as a personal research website for Binxu Wang, showcasing publications, projects, and academic content.

## Commands

### Build and Development
```bash
# Build the site for production
hugo --gc --minify

# Build with specific base URL (used by Netlify)
hugo --gc --minify -b $URL

# Build for development/preview
hugo --gc --minify --buildFuture

# Local development server (standard Hugo)
hugo server
```

### Search Index Generation
```bash
# Generate search index (run after build)
npx pagefind --source 'public'
```

## Architecture

### Hugo Configuration
- **Main config**: `config/_default/hugo.yaml` - Core Hugo settings, site metadata, taxonomies
- **Parameters**: `config/_default/params.yaml` - Site appearance, SEO, header/footer settings  
- **Menus**: `config/_default/menus.yaml` - Navigation structure
- **Languages**: `config/_default/languages.yaml` - Internationalization
- **Modules**: `config/_default/module.yaml` - Hugo module dependencies

### Content Structure
- **Homepage**: `content/_index.md` - Landing page with blocks (biography, publications, news, etc.)
- **Author profiles**: `content/authors/admin/_index.md` - Personal information, CV, skills
- **Publications**: `content/publication/*/index.md` - Academic papers with metadata and citations
- **Projects**: `content/project/*/index.md` - Research projects and code repositories
- **Posts**: `content/post/*/index.md` - Blog posts and news articles
- **Events**: `content/event/*/index.md` - Talks and presentations
- **Teaching**: `content/teaching/*/index.md` - Course materials and educational content

### Static Assets
- **Media**: `assets/media/` - Images, icons, and other static files
- **Uploads**: `static/uploads/` - PDFs, CVs, and downloadable files
- **Generated**: `public/` - Built site output (auto-generated)

### Theme System
- Uses Hugo Blox Builder modules via Go modules (`go.mod`)
- Custom layouts in `layouts/partials/hooks/` for extending functionality
- Hugo version: 0.136.5 (specified in `netlify.toml` and `hugoblox.yaml`)

### Publication Management
- Bibliography file: `publications.bib` - BibTeX entries for all publications
- Individual publication folders with `cite.bib` files for each paper
- Automatic citation formatting and metadata extraction

## Key Files to Modify

- **Site content**: Edit files in `content/` directories
- **Personal info**: `content/authors/admin/_index.md`
- **Homepage**: `content/_index.md`
- **Site settings**: `config/_default/params.yaml`
- **Navigation**: `config/_default/menus.yaml`
- **Publications**: Add new folders in `content/publication/` or update `publications.bib`

## Deployment

The site is automatically deployed on Netlify when changes are pushed to the repository. The build command includes Hugo compilation and search index generation.