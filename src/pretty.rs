use crate::Atom;
use pretty::RcDoc;
use std::error::Error;

pub fn render(atoms: &[Atom], indent_level: isize) -> Result<String, Box<dyn Error>> {
    let doc = atoms_to_doc(&mut 0, &atoms, indent_level);
    let mut rendered = String::new();
    doc.render_fmt(usize::max_value(), &mut rendered)?;
    Ok(rendered)
}

fn atoms_to_doc<'a>(i: &mut usize, atoms: &'a [Atom], indent_level: isize) -> RcDoc<'a, ()> {
    let mut doc = RcDoc::nil();
    while *i < atoms.len() {
        let atom = &atoms[*i];
        if let Atom::IndentEnd = atom {
            return doc;
        } else {
            doc = doc.append(match atom {
                Atom::Empty => RcDoc::text(""),
                Atom::Leaf { content, .. } => RcDoc::text(content.trim_end()),
                Atom::Literal(s) => RcDoc::text(s),
                Atom::Hardline => RcDoc::hardline(),
                Atom::IndentEnd => unreachable!(),
                Atom::IndentStart => {
                    *i = *i + 1;
                    atoms_to_doc(i, atoms, indent_level).nest(indent_level)
                }
                Atom::Softline { .. } => unreachable!(),
                Atom::Space => RcDoc::space(),
            });
        }
        *i = *i + 1;
    }
    return doc;
}