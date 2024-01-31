$(() => {
  const currentComponentId = window.DecidimAnonymousProposals.currentComponentId;
  if (!currentComponentId) {
    return;
  }

  const titleStoreId = `new_proposal:title:${currentComponentId}`;
  const bodyStoreId = `new_proposal:body:${currentComponentId}`;
  const $form = $("form.new_proposal");

  if (!$form.length) {
    window.localStorage.removeItem(titleStoreId);
    window.localStorage.removeItem(bodyStoreId);
    return;
  } else {
    const titleStored = window.localStorage.getItem(titleStoreId);
    const bodyStored = window.localStorage.getItem(bodyStoreId);

    const $title = $form.find("#proposal_title");
    const $body = $form.find("#proposal_body");

    const save = () => {
      const titleVal = $title.val();
      const bodyVal = $body.val();

      if (titleVal.length > 0) {
        window.localStorage.setItem(titleStoreId, $title.val());
      }

      if (bodyVal.length > 0) {
        window.localStorage.setItem(bodyStoreId, $body.val());
      }
    }

    if(titleStored) {
      $title.val(titleStored);
    } else {
      save();
    }

    if(bodyStored) {
      $body.val(bodyStored);
    } else {
      save();
    }

    $title.on("change", () => {
      save();
    });

    $body.on("change", () => {
      save();
    });

    $form.on("formvalid.zf.abide", function() {
      window.localStorage.removeItem(titleStoreId);
      window.localStorage.removeItem(bodyStoreId);
    });
  }
});
