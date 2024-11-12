export const idlFactory = ({ IDL }) => {
  const BlogPost = IDL.Record({
    'id' : IDL.Nat,
    'title' : IDL.Text,
    'content' : IDL.Text,
    'timestamp' : IDL.Int,
  });
  return IDL.Service({
    'createPost' : IDL.Func([IDL.Text, IDL.Text], [BlogPost], []),
    'getPosts' : IDL.Func([], [IDL.Vec(BlogPost)], ['query']),
    'initializeContent' : IDL.Func([], [], []),
  });
};
export const init = ({ IDL }) => { return []; };
