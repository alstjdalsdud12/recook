package com.springmvc.controller;

import java.util.Arrays;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.springmvc.dao.RecipeDAO;
import com.springmvc.domain.Recipe;

@Controller
public class HomeController {

    private RecipeDAO recipeDAO = new RecipeDAO();

    @GetMapping("/")
    public String home() {
        return "home";
    }

    @GetMapping("/recipe/search")
    public String recipeSearch(
            @RequestParam(value = "ingredients", required = false, defaultValue = "") String ingredients,
            Model model) {

        List<String> ingredientList = Arrays.asList(ingredients.split(","));
        List<Recipe> recipeList = recipeDAO.selectByIngredients(ingredientList);

        model.addAttribute("recipeList", recipeList);
        model.addAttribute("ingredients", ingredients);
        model.addAttribute("totalCount", recipeList.size());

        return "result";
    }
}