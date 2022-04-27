package com.laptrinhjavaweb.controller.admin;

import com.laptrinhjavaweb.dto.BuildingDTO;
import com.laptrinhjavaweb.dto.request.BuildingSearchRequest;
import com.laptrinhjavaweb.service.IBuildingService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

@Controller(value = "buildingControllerOfAdmin")
public class BuildingController {

	@Autowired
	private IBuildingService buildingService;

	@RequestMapping(value = "/admin/building-list", method = RequestMethod.GET)
	public ModelAndView buildingList(@ModelAttribute("modelSearch") BuildingSearchRequest buildingSearchRequest) {
		ModelAndView mav = new ModelAndView("admin/building/building-list");
		mav.addObject("modelSearch", buildingSearchRequest);
		mav.addObject("buildings", buildingService.findAllBuildingResponse());
		mav.addObject("districtmaps", buildingService.getDistrictMaps());
		mav.addObject("buildingTypesMap",buildingService.getBuildingTypesMaps());
		return mav;
	}

	@RequestMapping(value = "/admin/building-edit", method = RequestMethod.GET)
	public ModelAndView buildingEdit(@ModelAttribute("modelEdit") BuildingDTO buildingDTO) {
		ModelAndView mav = new ModelAndView("admin/building/building-edit");
		mav.addObject("buildingModel", new BuildingDTO());
		mav.addObject("districtmaps", buildingService.getDistrictMaps());
		mav.addObject("buildingTypesMap",buildingService.getBuildingTypesMaps());
		return mav;
	}

	@RequestMapping(value = "/admin/building-edit-{id}", method = RequestMethod.GET)
	public ModelAndView buildingEditDetail(@PathVariable("id") long id) {
		ModelAndView mav = new ModelAndView("admin/building/building-edit");
		mav.addObject("modelEdit", buildingService.getBuldingById(id));
		mav.addObject("districtmaps", buildingService.getDistrictMaps());
		mav.addObject("buildingTypesMap",buildingService.getBuildingTypesMaps());
		return mav;
	}

	@RequestMapping(value = "/admin/building-search", method = RequestMethod.GET)
	public ModelAndView buildingSearch(@ModelAttribute("modelSearch") BuildingSearchRequest buildingSearchRequest) {
		ModelAndView mav = new ModelAndView("admin/building/building-list");
		mav.addObject("modelSearch", buildingSearchRequest);
		mav.addObject("districtmaps", buildingService.getDistrictMaps());
		mav.addObject("buildingTypesMap",buildingService.getBuildingTypesMaps());
		mav.addObject("buildings", buildingService.findBuildingSearch(buildingSearchRequest));
		return mav;
	}

}
